//
//  ManageTools.h
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/16.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageTools : NSObject

- (instancetype)init __deprecated_msg("Method deprecated. Use the class method `sharedInstance`") __unavailable;

+ (instancetype)sharedInstance;


+ (void)idCardDeviceSelectedView:(void(^)(NSDictionary *result))result;

+ (void)simCardDeviceSelectedView:(void (^)(NSDictionary *result))result;

@end
