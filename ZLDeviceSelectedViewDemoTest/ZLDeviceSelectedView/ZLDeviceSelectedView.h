//
//  ZLDeviceSelectedView.h
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZLDeviceSelectedViewHandler)(NSDictionary *result);

@interface ZLDeviceSelectedView : UIView

@property (nonatomic, strong) NSArray *detailArray;

@property (nonatomic, copy) NSString *storedKey;

@property (nonatomic, copy) NSString *title;

- (instancetype)init __deprecated_msg("Method deprecated. Use `initWithTitle:detailArray:` or `initWithTitle:detailArray:storeKey`") __unavailable;
- (instancetype)initWithTitle:(NSString *)title detailArray:(NSArray *)detailArray;
- (instancetype)initWithTitle:(NSString *)title detailArray:(NSArray *)detailArray selectedDeviceResult:(ZLDeviceSelectedViewHandler) result;
- (instancetype)initWithTitle:(NSString *)title detailArray:(NSArray *)detailArray storeKey:(NSString *)storeKey selectedDeviceResult:(ZLDeviceSelectedViewHandler) result;

+ (instancetype)deviceSelectedViewWithTitle:(NSString *)title detailArray:(NSArray *)detailArray;
+ (instancetype)deviceSelectedViewWithTitle:(NSString *)title detailArray:(NSArray *)detailArray selectedDeviceResult:(ZLDeviceSelectedViewHandler) result;
+ (instancetype)deviceSelectedViewWithTitle:(NSString *)title detailArray:(NSArray *)detailArray storeKey:(NSString *)storeKey selectedDeviceResult:(ZLDeviceSelectedViewHandler) result;

- (void)getSelectedDeviceResult:(ZLDeviceSelectedViewHandler)result;

- (void)show;

@end
