//
//  RemoteNotification.h
//  Okta Notification Example
//
//  Created by Umang Shah on 5/15/15.
//  Copyright (c) 2015 Okta Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteNotification : NSObject
@property (strong, nonatomic) NSString *channel;
@property (strong, nonatomic) NSString *message;
@end
