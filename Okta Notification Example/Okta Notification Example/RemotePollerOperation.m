//
//  RemotePollerOperation.m
//  Okta Notification Example
//
//  Created by Umang Shah on 5/15/15.
//  Copyright (c) 2015 Okta Inc. All rights reserved.
//

#import "RemotePollerOperation.h"

@interface RemotePollerOperation ()
@property (nonatomic, copy) RemoteFetchBlock remoteFetchBlock;
@property (nonatomic, assign) int interval;
@end


@implementation RemotePollerOperation
- (instancetype)initWithRemoteFetchBlock:(RemoteFetchBlock)remoteFetchBlock andInterval:(int)interval {
    self = [super init];
    if (self) {
        self.remoteFetchBlock = remoteFetchBlock;
        self.interval = interval;
    }
    return self;
}

- (void)main {
    if (self.isCancelled) {
        return;
    }
    
    NSArray *notifications = self.remoteFetchBlock();
    if (notifications != nil && notifications.count > 0) {
        [self.remotePollerOperationDelegate notifyForNotifications:notifications];
    }
    sleep(self.interval);
    
    [self.remotePollerOperationDelegate addNextPollingOperation];
}

@end
