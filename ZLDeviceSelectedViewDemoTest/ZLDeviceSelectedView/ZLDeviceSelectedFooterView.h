//
//  ZLDeviceSelectedFooterView.h
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZLDeviceSelectedFooterButtonHandler)(UIButton *button);

@class ZLDeviceSelectedFooterView;

@protocol ZLDeviceSelectedFooterViewDelegate <NSObject>

@optional

- (void)zl_cancleButtonDidClick:(UIButton *)cancelButton;
- (void)zl_confirmButtonDidClick:(UIButton *)confirmButton;

@end

@interface ZLDeviceSelectedFooterView : UIView

@property (nonatomic, weak) id <ZLDeviceSelectedFooterViewDelegate> delegate;

- (void)cancleButtonDidClick:(ZLDeviceSelectedFooterButtonHandler)cancleBlock;
- (void)confirmButtonDidClick:(ZLDeviceSelectedFooterButtonHandler)confirmBlock;

@end
