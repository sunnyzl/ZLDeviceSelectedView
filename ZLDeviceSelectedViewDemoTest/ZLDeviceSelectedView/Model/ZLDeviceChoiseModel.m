//
//  ZLDeviceChoiseModel.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceChoiseModel.h"

@implementation ZLDeviceChoiseModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[[self class] alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)device
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:device];
    }
    return self;
}

@end
