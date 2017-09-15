//
//  PWFNotificationInfo.h
//  ViewTest
//
//  Created by pengweifeng on 2017/9/13.
//  Copyright © 2017年 pengweifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWFNotification : NSObject
/** 通知的名字 */
@property (nonatomic, copy, readonly) NSString *notificationName;
/** 通知发送者 */
@property (nonatomic, strong) id object;
/** 通知中的用户信息 */
@property (nonatomic, strong) NSDictionary *userInfo;
/** 观察该通知的对象收到通知后要执行的选择器 */
@property (nonatomic, assign) SEL sel;
/** 观察者 */
@property (nonatomic, weak) id observer;

/**
 初始化(必须用该函数初始化),否则无法赋值notificationName
 
 @param name 通知名字
 @return PWFNotificationInfo 实例
 */
- (instancetype)initWithName:(NSString *)name;

/**
 从另一个实例实例化一个新的实例
 
 @param notiInfo 传入notiInfo对象
 @return 生成的新PWFNotificationInfo 对象
 */
+ (instancetype)notificationInfoWithNotificationInfo:(PWFNotification *)notiInfo;

@end
