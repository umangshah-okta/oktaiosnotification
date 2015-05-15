//
//  RemoteNotificationPoller.h
//  Okta Notification Example
//
//  Created by Umang Shah on 5/15/15.
//  Copyright (c) 2015 Okta Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemotePollerOperation.h"


@interface RemoteNotificationPoller : NSObject
+ (void)startPolling;
+ (void)assignRemoteFetchBlock:(RemoteFetchBlock)remoteFetchBlock;
@end
