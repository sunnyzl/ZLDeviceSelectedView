//
//  ZLDeviceSelectedDeviceContentView.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedDeviceContentView.h"
#import "ZLDeviceSelectedDeviceView.h"
#import "ZLDeviceSelectedViewModel.h"
#import "ZLDeviceSlectedViewConst.h"
#import "ZLDeviceChoiseModel.h"

static NSInteger const deviceMaxCount = 9;
static CGFloat const marginBetweenTwoDevice = 4.f;
static CGFloat const deviceViewH = 26.f;
static CGFloat const deviceContentViewBottom = 20.f;

@interface ZLDeviceSelectedDeviceContentView ()

@property (nonatomic, weak) ZLDeviceSelectedDeviceView *selectedDevice;
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, strong) NSArray *devices;


@end

@implementation ZLDeviceSelectedDeviceContentView

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
    for (NSInteger index = 0; index < deviceMaxCount; index++) {
        ZLDeviceSelectedDeviceView *deviceView = [ZLDeviceSelectedDeviceView buttonWithType:UIButtonTypeCustom];
        deviceView.tag = index;
        [self addSubview:deviceView];
        [ deviceView addTarget:self action:@selector(deviceDidChoise:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)deviceDidChoise:(ZLDeviceSelectedDeviceView *)device {
    [[NSNotificationCenter defaultCenter]  postNotificationName:ZLDeviceSelectedDeviceViewNotification
                                                         object:self
                                                       userInfo:@{
                                                                  ZLDeviceSelectedDeviceViewDeviceModel : device.deviceModel,
                                                                  ZLDeviceSelectedDeviceViewDeviceIndexPath : [NSIndexPath indexPathForRow:device.tag inSection:self.model.section]}];
    self.selectedDevice.enabled = YES;
    device.enabled = NO;
    self.selectedDevice = device;
    self.model.currentSelectedDeviceIndex = device.tag;
}

+ (CGFloat)heightWithCount:(NSInteger)count {
    NSInteger maxCol = [self deviceMaxCol:count];
    NSInteger row = (count + maxCol - 1) / maxCol;
    CGFloat photosH = row * deviceViewH + (row - 1) * marginBetweenTwoDevice + deviceContentViewBottom;
    return photosH;
}


- (void)setModel:(ZLDeviceSelectedViewModel *)model {
    _model = model;
    self.devices = model.vendor;
    NSInteger count = self.devices.count;
    for (NSInteger index = 0; index < self.subviews.count; index++) {
        ZLDeviceSelectedDeviceView *deviceView = self.subviews[index];
        if (index < count) {
            deviceView.deviceModel = self.devices[index];
            deviceView.deviceModel.deviceNumber = [NSString stringWithFormat:@"%ld", model.section];
            deviceView.hidden = NO;
            if (model.currentSelectedDeviceIndex == index) {
                [self deviceDidChoise:deviceView];
            }
        } else {
            deviceView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
        NSInteger deviceCount = self.devices.count;
        NSInteger maxCol = [self deviceMaxCol:deviceCount];
        CGFloat deviceViewX = 0.f, deviceViewY = 0.f, deviceViewW = 0.f, leftMargin = 0.f;
        for (NSInteger index = 0; index < deviceCount; index++) {
            ZLDeviceSelectedDeviceView *deviceView = self.subviews[index];
            NSInteger col = index % maxCol;
            NSInteger row = index / maxCol;
            leftMargin = 60.f / maxCol;
            deviceViewW = (self.bounds.size.width - 2 * leftMargin - (maxCol - 1) * marginBetweenTwoDevice) / maxCol;
            
            deviceViewX = leftMargin + col * (deviceViewW + marginBetweenTwoDevice);
            deviceViewY = row * (deviceViewH + marginBetweenTwoDevice);
            deviceView.frame = CGRectMake(deviceViewX, deviceViewY, deviceViewW, deviceViewH);
        }
}

+ (NSInteger)deviceMaxCol:(NSInteger)count {
    if (count == 1) {
        return 1;
    } else {
        return ((count == 2) || (count == 4)) ? 2 : 3;
    }
}

- (NSInteger)deviceMaxCol:(NSInteger)count {
    if (count == 1) {
        return 1;
    } else {
        return ((count == 2) || (count == 4)) ? 2 : 3;
    }
}

@end
