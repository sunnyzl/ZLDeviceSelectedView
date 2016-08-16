//
//  ZLDeviceSelectedView.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDeviceSelectedView.h"
#import "ZLDeviceSelectedTitleView.h"
#import "ZLDeviceSelectedHeaderView.h"
#import "ZLDeviceSelectedFooterView.h"
#import "ZLDeviceSelectedViewCell.h"
#import "ZLDeviceSlectedViewConst.h"
#import "ZLDeviceSelectedViewModel.h"
#import "ZLDeviceChoiseModel.h"
#import "SVProgressHUD.h"
#import "Masonry.h"


static CGFloat const headerHeight = 80.f;
static CGFloat const titleFooterHeight = 50.f;
static NSTimeInterval const animationDuration = .3f;
static CGFloat const deviceTableScale = .8f;
static NSString *cellID = @"ZLDeviceSelectedViewCell";


#define ZLDeviceSelectedDeviceViewSelectedSection(storedKey) ([NSString stringWithFormat:@"ZLDeviceSelectedDeviceViewSelectedSection%@", (storedKey) ? (storedKey) : @""])
#define ZLDeviceSelectedDeviceViewSelectedRow(storedKey) ([NSString stringWithFormat:@"ZLDeviceSelectedDeviceViewSelectedRow%@", (storedKey) ? (storedKey) : @""])
#define ZLDeviceSelectedDeviceViewHeight(storedKey) ([NSString stringWithFormat:@"ZLDeviceSelectedDeviceViewHeight%@", (storedKey) ? (storedKey) : @""])

@interface ZLDeviceSelectedView ()
<
UITableViewDataSource,
UITableViewDelegate,
ZLDeviceSelectedHeaderDelegate,
ZLDeviceSelectedFooterViewDelegate
>


@property (nonatomic, strong) NSArray *detailArray;
@property (nonatomic, copy) NSString *storedKey;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) ZLDeviceSelectedTitleView *titleView;
@property (nonatomic, assign) NSInteger preSection;
@property (nonatomic, assign) CGFloat tableViewOriginHeight;

@property (nonatomic, assign, getter=isFirstIncome) BOOL firstIncome;

@property (nonatomic, strong) ZLDeviceChoiseModel *selectedDeviceModel;
@property (nonatomic, strong) NSIndexPath *selectedDeviceIndexPath;

@property (nonatomic, copy) ZLDeviceSelectedViewHandler result;
@property (nonatomic, strong) ZLDeviceSelectedHeaderView *preHeader;

@end

@implementation ZLDeviceSelectedView


#pragma mark - LifeCycle Method
#pragma mark - LifeCycle Method
+ (instancetype)deviceSelectedViewWithTitle:(NSString *)title detailArray:(NSArray *)detailArray storeKey:(NSString *)storeKey selectedDeviceResult:(ZLDeviceSelectedViewHandler)result{
    return [[[self class] alloc]  initWithTitle:title detailArray:detailArray storeKey:storeKey selectedDeviceResult:result];
}

- (instancetype)initWithTitle:(NSString *)title detailArray:(NSArray *)detailArray storeKey:(NSString *)storeKey selectedDeviceResult:(ZLDeviceSelectedViewHandler)result{
    if (self = [super init]) {
        self.firstIncome = YES;
        self.backgroundColor = [UIColor colorWithWhite:.1f alpha:.6f];
        self.alpha = 0.1f;
        [self initialize];
        self.title = title;
        self.storedKey = storeKey;
        self.detailArray = detailArray;
        self.result = [result copy];
    }
    return self;
}

- (void)initialize {
    self.preSection = -1;
    [self addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choiseDevice:) name:ZLDeviceSelectedDeviceViewNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = [[UIScreen mainScreen] bounds];
}

#pragma mark - public method

- (void)getSelectedDeviceResult:(ZLDeviceSelectedViewHandler)result {
    _result = [result copy];
}
- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    NSNumber *section = [[NSUserDefaults standardUserDefaults] objectForKey:ZLDeviceSelectedDeviceViewSelectedSection(self.storedKey)];
    if (section != nil) {
        NSInteger sectionInteger = [section integerValue];
        ZLDeviceSelectedHeaderView *header = (ZLDeviceSelectedHeaderView *)[self tableView:self.tableView viewForHeaderInSection:sectionInteger];
        ZLDeviceSelectedViewModel *model = self.detailArray[sectionInteger];
        if (model.isCanChoice) {
            [header didSelectedInSection:sectionInteger];
        }
        self.preHeader = header;
    }
    [UIView animateWithDuration:animationDuration
                          delay:0.f
         usingSpringWithDamping:.7f
          initialSpringVelocity:.5f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 1.f;
                         self.tableView.transform = CGAffineTransformIdentity;
                     } completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:.3f
                          delay:0.f
         usingSpringWithDamping:.7f
          initialSpringVelocity:.5f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 0.f;
                         self.tableView.transform = CGAffineTransformMakeScale(.5f, .5f);
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - setter method
- (void)setDetailArray:(NSArray *)detailArray {
    _detailArray = detailArray;
    WS(weakSelf);
    NSInteger count = (self.detailArray.count <= 3) ? self.detailArray.count : 3;
    CGFloat defaultCellHeight = [[[NSUserDefaults standardUserDefaults] objectForKey:ZLDeviceSelectedDeviceViewHeight(self.storedKey)] floatValue];
    if (self.isFirstIncome) {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.width.equalTo(weakSelf).multipliedBy(deviceTableScale);
            weakSelf.tableViewOriginHeight = headerHeight * count + titleFooterHeight * 2;
            make.height.mas_equalTo(weakSelf.tableViewOriginHeight + defaultCellHeight);
            make.top.equalTo(weakSelf).offset(([[UIScreen mainScreen] bounds].size.height - self.tableViewOriginHeight) / 2);
        }];
        self.firstIncome = NO;
    }
    else {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            weakSelf.tableViewOriginHeight = headerHeight * count + titleFooterHeight * 2;
            make.height.mas_equalTo(weakSelf.tableViewOriginHeight + defaultCellHeight);
            make.top.equalTo(weakSelf).offset(([[UIScreen mainScreen] bounds].size.height - self.tableViewOriginHeight) / 2);
        }];
    }
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleView.title = [title copy];
}

#pragma mark - lazyLoad method
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kRGBColorFromHex(0xE5F7FA);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZLDeviceSelectedViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
        
        ZLDeviceSelectedTitleView *titleView = [[ZLDeviceSelectedTitleView alloc] init];
        titleView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, titleFooterHeight);
        self.tableView.tableHeaderView = titleView;
        self.titleView = titleView;
        
        ZLDeviceSelectedFooterView *footerView = [[ZLDeviceSelectedFooterView alloc] init];
        footerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, titleFooterHeight);
        footerView.delegate = self;
        self.tableView.tableFooterView = footerView;
        self.tableView.layer.cornerRadius = 5.f;
        self.tableView.layer.masksToBounds = YES;
        self.tableView.transform = CGAffineTransformMakeScale(0, 0);
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.detailArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZLDeviceSelectedViewModel *model = self.detailArray[section];
    if (self.preSection == model.section) {
        return model.isSelected ? 1 : 0;
    } else {
        model.selected = NO;
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLDeviceSelectedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    ZLDeviceSelectedViewModel *headerModel = self.detailArray[indexPath.section];
    cell.model = headerModel;
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZLDeviceSelectedViewModel *model = self.detailArray[section];
    model.section = section;
    NSNumber *sectionNum = [[NSUserDefaults standardUserDefaults] objectForKey:ZLDeviceSelectedDeviceViewSelectedSection(self.storedKey)];
    NSNumber *rowNum = [[NSUserDefaults standardUserDefaults] objectForKey:ZLDeviceSelectedDeviceViewSelectedRow(self.storedKey)];
    if (sectionNum) {
        if ([sectionNum integerValue] == section) {
            model.currentSelectedDeviceIndex = [rowNum integerValue];
        } else {
            model.currentSelectedDeviceIndex = 0;
        }
    } else {
        model.currentSelectedDeviceIndex = 0;
    }
    ZLDeviceSelectedHeaderView *header = [ZLDeviceSelectedHeaderView sectionHeader];
    header.model = model;
    if (self.preHeader.model.section == header.model.section) {
        self.preHeader.model.selected = YES;
    }
    header.delegate = self;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLDeviceSelectedViewModel *model = self.detailArray[indexPath.section];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - ZLDeviceSelectedHeaderDelegate
- (void)zl_selectedHeader:(ZLDeviceSelectedHeaderView *)sectionHeader didSelected:(BOOL)selected section:(NSInteger)section {
    NSIndexPath *currPath = [NSIndexPath indexPathForRow:0 inSection:section];
    NSIndexPath *prePath = nil;
    ZLDeviceSelectedViewModel *preModel = nil;
    [self.tableView beginUpdates];
    if (self.preSection > -1) {
        prePath = [NSIndexPath indexPathForRow:0 inSection:self.preSection];
        preModel = self.detailArray[self.preSection];
        if (self.preSection != section) {
            if (preModel.isSelected) {
                [self.tableView deleteRowsAtIndexPaths:@[prePath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            [self.tableView insertRowsAtIndexPaths:@[currPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            if (selected) {
                [self.tableView insertRowsAtIndexPaths:@[currPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                [self.tableView deleteRowsAtIndexPaths:@[currPath]
                                      withRowAnimation:UITableViewRowAnimationTop];
            }
        }
    } else {
        [self.tableView insertRowsAtIndexPaths:@[currPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    self.preSection = section;
    [self.tableView endUpdates];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:ZLDeviceSelectedDeviceViewSelectedSection(self.storedKey)] == nil) {
        [self setupExpandTableViewAnimationWithHeaderView:sectionHeader selected:selected];
    } else {
        if (self.preHeader != nil) {
            [self setupExpandTableViewAnimationWithHeaderView:sectionHeader selected:selected];
        }
    }
}

- (void)setupExpandTableViewAnimationWithHeaderView:(ZLDeviceSelectedHeaderView *)sectionHeader selected:(BOOL)selected {
    [self.tableView  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset( selected ? (self.tableViewOriginHeight + sectionHeader.model.cellHeight) : self.tableViewOriginHeight);
    }];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.tableView setNeedsLayout];
        [self.tableView layoutIfNeeded];
    }];
}

#pragma mark - ZLDeviceSelectedDeviceViewNotification
- (void)choiseDevice:(NSNotification *)notification {
    self.selectedDeviceModel = notification.userInfo[ZLDeviceSelectedDeviceViewDeviceModel];
    self.selectedDeviceIndexPath = notification.userInfo[ZLDeviceSelectedDeviceViewDeviceIndexPath];
}

#pragma mark - ZLDeviceSelectedFooterViewDelegate
- (void)zl_cancleButtonDidClick:(UIButton *)cancelButton {
    [self dismiss];
}

- (void)zl_confirmButtonDidClick:(UIButton *)confirmButton {
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedDeviceIndexPath.section) forKey:ZLDeviceSelectedDeviceViewSelectedSection(self.storedKey)];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedDeviceIndexPath.row) forKey:ZLDeviceSelectedDeviceViewSelectedRow(self.storedKey)];
    ZLDeviceSelectedViewModel *selectedHeaderModel = self.detailArray[self.selectedDeviceIndexPath.section];
    [[NSUserDefaults standardUserDefaults] setObject:@(selectedHeaderModel.cellHeight) forKey:ZLDeviceSelectedDeviceViewHeight(self.storedKey)];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    resultDic[ZLKeyPath(self.selectedDeviceModel, deviceNumber)] = self.selectedDeviceModel.deviceNumber;
    resultDic[ZLKeyPath(self.selectedDeviceModel, vendorNumber)] = self.selectedDeviceModel.vendorNumber;
    if (self.selectedDeviceModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择设备" maskType:SVProgressHUDMaskTypeClear];
        
    } else {
        if (self.result) {
            self.result(resultDic);
        }
        [self dismiss];
    }
}

@end