//
//  RemoteNotificationPoller.m
//  Okta Notification Example
//
//  Created by Umang Shah on 5/15/15.
//  Copyright (c) 2015 Okta Inc. All rights reserved.
//

#import "RemoteNotificationPoller.h"

#import "RemoteNotification.h"

@interface RemoteNotificationPoller () <RemotePollerOperationDelegate>
@property (nonatomic, strong) NSOperationQueue *pollingQueue;
@property (nonatomic, copy) RemoteFetchBlock remoteFetchBlock;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) int interval;
@end


@implementation RemoteNotificationPoller
+ (RemoteNotificationPoller *)remoteNotificationPoller {
    static RemoteNotificationPoller *remoteNotificationPoller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        remoteNotificationPoller = [[self alloc] init];
        remoteNotificationPoller.pollingQueue = [[NSOperationQueue alloc] init];
        remoteNotificationPoller.pollingQueue.name = @"Remote Notification Polling Queue";
        remoteNotificationPoller.pollingQueue.maxConcurrentOperationCount = 1;
        remoteNotificationPoller.active = NO;
        remoteNotificationPoller.interval = 50;
    });
    return remoteNotificationPoller;
}

+ (void)startPolling {
    [[self remoteNotificationPoller] startPolling];
}

- (void)startPolling {
    [self.pollingQueue addOperationWithBlock:^{
        if (self.active) {
            return;
        }
        self.active = YES;
        RemotePollerOperation *pollingOperation = [[RemotePollerOperation alloc] initWithRemoteFetchBlock:self.remoteFetchBlock andInterval:self.interval];
        pollingOperation.remotePollerOperationDelegate = self;
        [self.pollingQueue addOperation:pollingOperation];
    }];
}


- (void)notifyForNotifications:(NSArray *)notifications {
    for (RemoteNotification *notification in notifications) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notification.channel object:notification];
    }
}

- (void)addNextPollingOperation {
    [self.pollingQueue addOperationWithBlock:^{
        if (!self.active) {
            return;
        }
        RemotePollerOperation *pollingOperation = [[RemotePollerOperation alloc] initWithRemoteFetchBlock:self.remoteFetchBlock andInterval:self.interval];
        pollingOperation.remotePollerOperationDelegate = self;
        [self.pollingQueue addOperation:pollingOperation];
    }];
}


+ (void)assignRemoteFetchBlock:(RemoteFetchBlock)remoteFetchBlock {
    [[self remoteNotificationPoller] assignRemoteFetchBlock:remoteFetchBlock];
}

- (void)assignRemoteFetchBlock:(RemoteFetchBlock)remoteFetchBlock {
    [self.pollingQueue addOperationWithBlock:^{
        self.remoteFetchBlock = remoteFetchBlock;
    }];
}



+ (void)stopPolling {
    [[self remoteNotificationPoller] stopPolling];
}

- (void)stopPolling {
    [self.pollingQueue cancelAllOperations];
    [self.pollingQueue addOperationWithBlock:^{
        self.active = NO;
    }];

}


@end
