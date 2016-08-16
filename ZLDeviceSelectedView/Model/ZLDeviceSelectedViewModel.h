//
//  ZLDeviceSelectedViewModel.h
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLDeviceChoiseModel;

@interface ZLDeviceSelectedViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *normalImage;
@property (nonatomic, copy) NSString *selectedImage;
@property (nonatomic, copy) NSString *tipsWhenHasNoneDevice;
@property (nonatomic, strong) NSArray <ZLDeviceChoiseModel *> *vendor;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) NSInteger currentSelectedDeviceIndex;
@property (nonatomic, assign, readonly, getter=isCanChoice) BOOL canChoice;


+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
