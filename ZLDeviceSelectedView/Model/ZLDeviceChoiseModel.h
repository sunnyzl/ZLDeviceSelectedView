//
//  ZLDeviceChoiseModel.h
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLDeviceChoiseModel : NSObject

@property (nonatomic, copy) NSString  *deviceNumber;
@property (nonatomic, copy) NSString  *vendorNumber;
@property (nonatomic, copy) NSString  *vendorName;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
