//
//  PWFNotificationCenter.m
//  ViewTest
//
//  Created by pengweifeng on 2017/9/13.
//  Copyright © 2017年 pengweifeng. All rights reserved.
//

#import "PWFNotificationCenter.h"
#import "PWFWeakArray.h"
#import "PWFNotification.h"

static PWFNotificationCenter *sharedNotificationCenter;

@interface PWFNotificationCenter ()

/** 通知名字->观察者 的字典 */
@property (nonatomic, strong) NSMutableDictionary<NSString *,PWFWeakArray *> *observerDic;
/** 通知名字->通知信息 的字典 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *notificationDic;

@property (nonatomic, strong) NSLock *lock;

@end

@implementation PWFNotificationCenter

+ (instancetype)defaultCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNotificationCenter = [self new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    });
    
    return sharedNotificationCenter;
}

- (NSMutableDictionary *)observerDic {
    if (_observerDic == nil) {
        _observerDic = [NSMutableDictionary dictionary];
    }
    
    return _observerDic;
}

- (NSMutableDictionary *)notificationDic {
    if (_notificationDic == nil) {
        _notificationDic = [NSMutableDictionary dictionary];
    }
    
    return _notificationDic;
}

- (NSLock *)lock {
    if (_lock == nil) {
        _lock = [[NSLock alloc] init];
    }
    
    return _lock;
}

- (void)pwf_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject {
    NSAssert(observer != nil, @"observer can't be nil");
    NSAssert(aName.length > 0 , @"notification name invalid");
    
    if (self.observerDic[aName] == nil) {
        self.observerDic[aName] = [PWFWeakArray new];
        self.notificationDic[aName] = [NSMutableArray array];
    } else {
        BOOL exist = [self isObserverAdded:observer forName:aName];
        if (exist) {
            return;
        }
    }
    
    PWFWeakArray *weakObserverArr = self.observerDic[aName];
    [weakObserverArr addObject:observer];
    
    PWFNotification *notiInfo = [[PWFNotification alloc] initWithName:aName];
    notiInfo.object = anObject;
    notiInfo.sel = aSelector;
    notiInfo.observer = observer;
    NSMutableArray *notiInfoArr = self.notificationDic[aName];
    [notiInfoArr addObject:notiInfo];
}

- (void)pwf_addObserverForName:(nullable NSNotificationName)aName object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block {
    NSAssert(aName.length > 0 , @"notification name invalid");
    //暂时没实现
}

- (void)pwf_postNotificationName:(NSString *)aName object:(id)object userInfo:(NSDictionary *)aUserInfo {
    PWFWeakArray *observerArr = self.observerDic[aName];
    if (observerArr.count == 0) {   //没有找到对应的观察者数组直接返回
        return;
    }
    
    for (id anObserver in observerArr.allValidObjects) {
        PWFNotification *notiInfo = [self notificationInfoWithName:aName observer:anObserver];
        
        if (notiInfo == nil) {
            continue;
        }
        
        //如果notiInfo.object == nil,则其监听全部"aaName"的通知;
        //如果notiInfo.object != nil && notiInfo.object == object,也要发送通知;
        //其它情况不发送通知
        if (notiInfo.object != nil && notiInfo.object != object) {
            continue;
        }
        
        if ([notiInfo.observer respondsToSelector:notiInfo.sel] == NO) {
            continue;
        }
        
        //如果有userInfo参数带上该参数
        if (aUserInfo.count > 0) {
            notiInfo.userInfo = [aUserInfo copy];
        }

        NSString *selStr = NSStringFromSelector(notiInfo.sel);
        
        PWFNotification *aNewNotiInfo = nil;
        if ([selStr hasSuffix:@":"] == YES) {       //SEL带参数
            aNewNotiInfo = [PWFNotification notificationInfoWithNotificationInfo:notiInfo];
        }
        
        if (self.postNotificationInMainThread == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [notiInfo.observer performSelector:notiInfo.sel withObject:aNewNotiInfo afterDelay:0];
            });
        } else {
            [notiInfo.observer performSelector:notiInfo.sel withObject:aNewNotiInfo afterDelay:0];
        }
    }
}

- (void)pwf_postNotificationName:(NSString *)aName object:(id)object {
    [self pwf_postNotificationName:aName object:object userInfo:nil];
}

- (void)pwf_postNotificationName:(NSString *)aName {
    [self pwf_postNotificationName:aName object:nil userInfo:nil];
}

- (BOOL)isObserverAdded:(id)observer forName:(NSString *)aName {
    PWFWeakArray *observerArr = self.observerDic[aName];
    if (observerArr.validCount == 0) {
        return NO;
    }
    
    BOOL added = NO;
    for (id anObserver in observerArr.allValidObjects) {
        if (observer == anObserver) {   //observer exists
            added = YES;
            break;
        }
    }
    
    return added;
}

- (PWFNotification *)notificationInfoWithName:(NSString *)aName observer:(id)anObserver {
    NSMutableArray *notificationInfoArr = self.notificationDic[aName];
    if (notificationInfoArr.count == 0) {
        return nil;
    }
    
    PWFNotification *notiInfo;
    for (PWFNotification *aNotificationInfo in notificationInfoArr) {
        if (aNotificationInfo.observer == anObserver) {
            notiInfo = aNotificationInfo;
            break;
        }
    }
    
    return notiInfo;
}

/**
 收到内存警告时,清空那些NULL observer
 */
- (void)didReceiveMemoryWarning {
    [self.lock lock];
    
    [self clearObserverDictionary];
    [self clearNotificationDictionary];
    
    [self.lock unlock];
}

- (void)clearObserverDictionary {
    if (self.observerDic.count == 0) {
        return;
    }
    
    for (NSString *key in self.observerDic) {
        PWFWeakArray *rawObserverArr = self.observerDic[key];
        
        if (rawObserverArr.count == 0) {
            continue;
        }
        
        PWFWeakArray *observerArr = [PWFWeakArray new];
        for (int i = 0; i < rawObserverArr.count; i++) {
            if ([rawObserverArr isNullObjectAtIndex:i] == NO) {
                [observerArr addObject:[rawObserverArr objectAtIndex:i]];
            }
        }
        
        self.observerDic[key] = observerArr;
    }
}

- (void)clearNotificationDictionary {
    if (self.notificationDic.count == 0) {
        return;
    }
    
    for (NSString *key in self.notificationDic) {
        NSMutableArray *rawNotificationArr = self.notificationDic[key];
        
        if (rawNotificationArr.count == 0) {
            continue;
        }
        
        NSMutableArray *notificationArr = [NSMutableArray array];
        for (int i = 0; i < rawNotificationArr.count; i++) {
            PWFNotification *noti = [rawNotificationArr objectAtIndex:i];
            if (noti.observer != nil) {
                [notificationArr addObject:noti];
            }
        }
        
        self.notificationDic[key] = notificationArr;
    }
}
@end
