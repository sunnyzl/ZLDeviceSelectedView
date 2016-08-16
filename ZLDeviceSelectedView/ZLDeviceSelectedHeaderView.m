//
//  ZLDeviceSelectedHeaderView.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedHeaderView.h"
#import "ZLDeviceSelectedViewModel.h"
#import "ZLDeviceSlectedViewConst.h"
#import "SVProgressHUD.h"

@interface ZLDeviceSelectedHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomDivider;

@property (nonatomic, assign, getter=isHeaderCanChoice) BOOL headerCanChoice;
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet UILabel *selectedTitle;
@property (weak, nonatomic) IBOutlet UILabel *tipsTitle;

@end

@implementation ZLDeviceSelectedHeaderView

+ (instancetype)sectionHeader {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setModel:(ZLDeviceSelectedViewModel *)model {
    _model = model;
//    NSAssert(self.delegate, @"请先设置代理");
    [self.icon setBackgroundImage:[UIImage imageNamed:model.normalImage] forState:UIControlStateNormal];
    [self.icon setBackgroundImage:[UIImage imageNamed:model.selectedImage] forState:UIControlStateSelected];
    self.titleLabel.text = model.title;
    [self.titleLabel sizeToFit];
    self.selectedTitle.text = model.title;
    [self.selectedTitle sizeToFit];
    self.tipsTitle.text = @"Choise the device";
    [self.tipsTitle sizeToFit];
    self.headerCanChoice = model.vendor.count > 0;
    [self.model addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([change objectForKey:NSKeyValueChangeNewKey]) {
        self.icon.selected = self.model.selected;
        self.titleLabel.hidden = self.model.selected;
        self.selectedView.hidden = !self.model.selected;
        self.backgroundColor = self.model.selected ? kRGBColorFromHex(0xE5F7FA) : [UIColor whiteColor];
        self.bottomDivider.hidden = self.model.selected;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.headerCanChoice = NO;
    self.selectedView.hidden = YES;
    self.titleLabel.hidden = NO;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(didSelectedTheHeader:)]];
}

- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"selected"];
}

- (void)didSelectedInSection:(NSInteger)section {
    if (section == self.model.section) {
        [self didSelectedTheHeader:nil];
    }
}

- (void)didSelectedTheHeader:(UITapGestureRecognizer *)tap {
    if (self.isHeaderCanChoice) {
        self.model.selected = !self.model.selected;
        if ([self.delegate respondsToSelector:@selector(zl_selectedHeader:didSelected:section:)]) {
            [self.delegate zl_selectedHeader:self didSelected:self.model.selected section:self.model.section];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:self.model.tipsWhenHasNoneDevice maskType:SVProgressHUDMaskTypeClear];
    }
}



@end
