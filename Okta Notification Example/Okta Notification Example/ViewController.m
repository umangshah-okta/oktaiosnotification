//
//  ViewController.m
//  Okta Notification Example
//
//  Created by Umang Shah on 5/15/15.
//  Copyright (c) 2015 Okta Inc. All rights reserved.
//

#import "ViewController.h"
#import "RemoteNotificationPoller.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *notificationQueue;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notificationHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceFromTop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.notificationQueue = [[NSOperationQueue alloc] init];
    self.notificationQueue.name = @"Notification Ui queue";
    self.notificationQueue.maxConcurrentOperationCount = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"TestNotification" object:nil];
    
    
    [RemoteNotificationPoller startPolling];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void) receiveTestNotification:(NSNotification *) notification {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
