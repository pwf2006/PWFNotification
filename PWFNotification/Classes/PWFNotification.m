//
//  PWFNotificationInfo.m
//  ViewTest
//
//  Created by pengweifeng on 2017/9/13.
//  Copyright © 2017年 pengweifeng. All rights reserved.
//

#import "PWFNotification.h"

@implementation PWFNotification

/**
 初始化(必须用该函数初始化),否则无法赋值notificationName

 @param name 通知名字
 @return PWFNotificationInfo 实例
 */
- (instancetype)initWithName:(NSString *)name {
    if (name == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _notificationName = name;
    }
    
    return self;
}

/**
 从另一个实例实例化一个新的实例

 @param notiInfo 传入notiInfo对象
 @return 生成的新PWFNotificationInfo 对象
 */
+ (instancetype)notificationInfoWithNotificationInfo:(PWFNotification *)notiInfo {
    if (notiInfo == nil) {
        return nil;
    }
    
    PWFNotification *aNotiInfo = [[PWFNotification alloc] initWithName:notiInfo.notificationName];
    aNotiInfo.object = notiInfo.object;
    aNotiInfo.sel = notiInfo.sel;
    aNotiInfo.observer = notiInfo.observer;
    aNotiInfo.userInfo = notiInfo.userInfo;
    
    return aNotiInfo;
}
@end
