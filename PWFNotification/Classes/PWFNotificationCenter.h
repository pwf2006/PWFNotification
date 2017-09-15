//
//  PWFNotificationCenter.h
//  ViewTest
//
//  Created by pengweifeng on 2017/9/13.
//  Copyright © 2017年 pengweifeng. All rights reserved.
//  通知中心, 观察者dealloc时不需要调用remove observer

#import <Foundation/Foundation.h>

@interface PWFNotificationCenter : NSObject
/** 发通知是否从主线程发通知(默认从当前线程发送通知) */
@property (nonatomic, assign) BOOL postNotificationInMainThread;

/**
 获取通知中心的单例

 @return 返回通知中心的单例
 */
+ (instancetype)defaultCenter;

/**
 注册通知中心

 @param observer 观察者
 @param aSelector selector
 @param aName 通知名字
 @param anObject 通知发送者
 */
- (void)pwf_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

/**
 发送通知

 @param aName 通知名字
 @param object 发送广播的对象
 @param aUserInfo 用户信息
 */
- (void)pwf_postNotificationName:(NSString *)aName object:(id)object userInfo:(NSDictionary *)aUserInfo;

/**
 发送通知

 @param aName 通知名字
 @param object 通知发送者
 */
- (void)pwf_postNotificationName:(NSString *)aName object:(id)object;

/**
 发送通知

 @param aName 通知名字
 */
- (void)pwf_postNotificationName:(NSString *)aName;

@end
