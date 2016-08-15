//
//  ZLDeviceSelectedViewCell.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedViewCell.h"
#import "ZLDeviceSelectedDeviceContentView.h"
#import "ZLDeviceSlectedViewConst.h"
#import "ZLDeviceSelectedViewModel.h"
#import "ZLDeviceChoiseModel.h"

@interface ZLDeviceSelectedViewCell ()
//<ZLDeviceSelectedDeviceContentViewDelegate>
@property (weak, nonatomic) IBOutlet ZLDeviceSelectedDeviceContentView *deviceContentView;

@end

@implementation ZLDeviceSelectedViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = kRGBColorFromHex(0xE5F7FA);
}

- (void)setModel:(ZLDeviceSelectedViewModel *)model {
    _model = model;
    self.deviceContentView.model = model;
    _model.cellHeight = [ZLDeviceSelectedDeviceContentView heightWithCount:self.deviceContentView.model.vendor.count];
}

@end
