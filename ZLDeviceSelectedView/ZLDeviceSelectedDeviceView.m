//
//  ZLDeviceSelectedDeviceView.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedDeviceView.h"
#import "ZLDeviceSlectedViewConst.h"
#import "ZLDeviceChoiseModel.h"

@interface ZLDeviceSelectedDeviceView ()

@property (nonatomic, strong) UIImageView *icon;

@end

@implementation ZLDeviceSelectedDeviceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize {
    self.backgroundColor = [UIColor whiteColor];
    self.icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_correct"]];
    [self addSubview:self.icon];
    self.icon.hidden = YES;
    self.layer.cornerRadius = 2.f;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self setValue:@"UIButtonTypeCustom" forKey:@"buttonType"];
    [self setTitleColor:kRGBColorFromHex(0x1D1D26) forState:UIControlStateNormal];
    [self setTitleColor:kRGBColorFromHex(0xFFB400) forState:UIControlStateDisabled];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat iconWH = self.bounds.size.height * 0.5;
    CGFloat iconX = self.bounds.size.width - iconWH;
    CGFloat iconY = self.bounds.size.height - iconWH;
    self.icon.frame = CGRectMake(iconX, iconY, iconWH, iconWH);
}

- (void)setDeviceModel:(ZLDeviceChoiseModel *)deviceModel {
    _deviceModel = deviceModel;
    [self setTitle:_deviceModel.vendorName forState:UIControlStateNormal];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    self.icon.hidden = enabled;
    self.layer.borderWidth = enabled ? 0.f : 2.f;
    self.layer.borderColor = !enabled ? [kRGBColorFromHex(0xFFB400) CGColor] : [UIColor clearColor].CGColor;
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
