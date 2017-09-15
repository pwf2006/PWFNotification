//
//  PWFObserverController.m
//  PWFNotification
//
//  Created by pengweifeng on 2017/9/14.
//  Copyright © 2017年 pwf2006. All rights reserved.
//

#import "PWFObserverController.h"
#import <PWFNotification/PWFNotificationHeader.h>

@interface PWFObserverController ()

@end

@implementation PWFObserverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"这里监听广播,dealloc不移除observer";
    
    [[PWFNotificationCenter defaultCenter] pwf_addObserver:self selector:@selector(receiveNotification:) name:@"pwf1" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)receiveNotification:(PWFNotification *)notification {
    NSLog(@"***:收到广播:%@", notification.notificationName);
}
@end
