//
//  ZLDeviceSelectedHeaderView.h
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLDeviceSelectedHeaderView, ZLDeviceSelectedViewModel;
@protocol ZLDeviceSelectedHeaderDelegate <NSObject>

- (void)zl_selectedHeader:(ZLDeviceSelectedHeaderView *)sectionHeader didSelected:(BOOL)selected section:(NSInteger)section;


@end

@interface ZLDeviceSelectedHeaderView : UIView

@property (nonatomic, strong) ZLDeviceSelectedViewModel *model;

@property (nonatomic, weak) id <ZLDeviceSelectedHeaderDelegate> delegate;

+ (instancetype)sectionHeader;

- (void)didSelectedInSection:(NSInteger)section;

@end
