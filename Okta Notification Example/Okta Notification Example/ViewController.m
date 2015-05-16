//
//  ViewController.m
//  Okta Notification Example
//
//  Created by Umang Shah on 5/15/15.
//  Copyright (c) 2015 Okta Inc. All rights reserved.
//

#import "ViewController.h"
#import "RemoteNotificationPoller.h"
#import "RemoteNotification.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *notificationQueue;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notificationHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceFromTop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.distanceFromTop.constant = - self.notificationHeight.constant;
    self.notificationQueue = [[NSOperationQueue alloc] init];
    self.notificationQueue.name = @"Notification Ui queue";
    self.notificationQueue.maxConcurrentOperationCount = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"all" object:nil];
    
    
    [RemoteNotificationPoller startPolling];
    
    RemoteNotification *notification = [[RemoteNotification alloc] init];
    notification.channel = @"all";
    notification.message = @"hello every one";
}


- (void)receiveTestNotification:(NSNotification *)notification {
    if ([notification.name isEqual:@"all"]) {
        [self.notificationQueue addOperationWithBlock:^{
            [self showNotification:notification.object];
            sleep(5);
            [self hideNotification];
            sleep(5);
        }];
    }
    
}

- (void)hideNotification {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.view layoutIfNeeded];
        self.distanceFromTop.constant = - self.notificationHeight.constant;
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }];
}

- (void)showNotification:(RemoteNotification *)notification {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.view layoutIfNeeded];
        self.message.text = notification.message;
        self.distanceFromTop.constant = 0;
        [UIView animateWithDuration:1.0 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
