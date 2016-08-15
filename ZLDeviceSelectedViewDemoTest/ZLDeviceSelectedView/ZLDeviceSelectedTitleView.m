//
//  ZLDeviceSelectedTitleView.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedTitleView.h"
#import "ZLDeviceSlectedViewConst.h"
#import "Masonry.h"

@interface ZLDeviceSelectedTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomDivider;

@end

@implementation ZLDeviceSelectedTitleView

+ (instancetype)titleViewWithTitle:(NSString *)title {
    ZLDeviceSelectedTitleView *deviceHeader = [[self alloc] init];
    deviceHeader.title = title;
    return deviceHeader;
}

+ (instancetype)titleView {
    return [self titleViewWithTitle:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomDivider];
    
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self.bottomDivider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.mas_offset(1.f);
        make.bottom.mas_offset(-1.f);
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textColor = kRGBColorFromHex(0x1D1D26);
    }
    return _titleLabel;
}

- (UIView *)bottomDivider {
    if (_bottomDivider == nil) {
        _bottomDivider = [[UIView alloc] init];
        _bottomDivider.backgroundColor = kRGBColorFromHex(0xF3F3F3);
    }
    return _bottomDivider;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = _title;
}

@end
