//
//  RemotePollerOperation.h
//  Okta Notification Example
//
//  Created by Umang Shah on 5/15/15.
//  Copyright (c) 2015 Okta Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSArray *(^RemoteFetchBlock)();

@protocol RemotePollerOperationDelegate
- (void)notifyForNotifications:(NSArray *)notifications;
- (void)addNextPollingOperation;
@end

@interface RemotePollerOperation : NSOperation
- (instancetype)initWithRemoteFetchBlock:(RemoteFetchBlock)remoteFetchBlock andInterval:(int)interval;
@end
