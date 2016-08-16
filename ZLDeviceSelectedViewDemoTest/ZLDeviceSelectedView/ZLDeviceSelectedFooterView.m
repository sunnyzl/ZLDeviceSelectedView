//
//  ZLDeviceSelectedFooterView.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedFooterView.h"
#import "ZLDeviceSlectedViewConst.h"
#import "Masonry.h"

@interface ZLDeviceSelectedFooterView ()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) ZLDeviceSelectedFooterButtonHandler cancleBlock;
@property (nonatomic, copy) ZLDeviceSelectedFooterButtonHandler confirmBlock;

@end
@implementation ZLDeviceSelectedFooterView

+ (instancetype)footerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    [self addSubview:self.cancelButton];
    [self addSubview:self.confirmButton];
    WS(weakSelf);
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf.confirmButton.mas_left);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.width.height.equalTo(weakSelf.cancelButton);
    }];
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.backgroundColor = kRGBColorFromHex(0xB1C0C0);
        [_cancelButton setTitle:@"cancle" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        _confirmButton.backgroundColor = kRGBColorFromHex(0x23CBD6);
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitle:@"confirm" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)cancleButtonDidClick:(ZLDeviceSelectedFooterButtonHandler)cancleBlock {
    _cancleBlock = [cancleBlock copy];
}

- (void)confirmButtonDidClick:(ZLDeviceSelectedFooterButtonHandler)confirmBlock {
    _confirmBlock = [confirmBlock copy];
}

- (void)cancleBtnDidClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(zl_cancleButtonDidClick:)]) {
        [self.delegate zl_cancleButtonDidClick:button];
    }
    if (_cancleBlock) {
        _cancleBlock(button);
    }
}
- (void)confirmBtnDidClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(zl_confirmButtonDidClick:)]) {
        [self.delegate zl_confirmButtonDidClick:button];
    }
    if (_confirmBlock) {
        _confirmBlock(button);
    }
}

@end
