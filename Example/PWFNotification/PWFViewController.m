//
//  PWFViewController.m
//  PWFNotification
//
//  Created by pwf2006 on 09/14/2017.
//  Copyright (c) 2017 pwf2006. All rights reserved.
//

#import "PWFViewController.h"
#import "PWFObserverController.h"
#import <PWFNotification/PWFNotificationHeader.h>

@interface PWFViewController ()

@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation PWFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = @"通知dealloc中不移除的测试";
    
    [self.view addSubview:self.pushBtn];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pushBtn.frame = CGRectMake(20, 100, 200, 30);
}

- (UIButton *)pushBtn {
    if (_pushBtn == nil) {
        _pushBtn = [UIButton new];
        _pushBtn.backgroundColor = [UIColor grayColor];
        [_pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
        [_pushBtn setTitle:@"压栈差延迟5秒杀发广播" forState:UIControlStateNormal];
    }
    
    return _pushBtn;
}


- (void)push {
    PWFObserverController *observerVC = [PWFObserverController new];
    [self.navigationController pushViewController:observerVC animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[PWFNotificationCenter defaultCenter] pwf_postNotificationName:@"pwf1"];
    });
}
@end
