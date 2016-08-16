//
//  ZLDeviceSelectedViewModel.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedViewModel.h"

@interface ZLDeviceSelectedViewModel ()


@property (nonatomic, assign, readwrite, getter=isCanChoice) BOOL canChoice;

@end

@implementation ZLDeviceSelectedViewModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    ZLDeviceSelectedViewModel *model = [[[self class] alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    model.canChoice = model.vendor.count > 0;
    return model;
}

- (void)setVendor:(NSArray<ZLDeviceChoiseModel *> *)vendor {
    _vendor = vendor;
    self.canChoice = vendor.count > 0;
}

@end
