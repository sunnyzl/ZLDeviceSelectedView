//
//  ZLDeviceSelectedDeviceContentView.h
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLDeviceSelectedViewModel;

@interface ZLDeviceSelectedDeviceContentView : UIView

@property (nonatomic, strong) ZLDeviceSelectedViewModel *model;
+ (CGFloat)heightWithCount:(NSInteger)count;

@end
