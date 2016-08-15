//
//  ViewController.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/11.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ViewController.h"
#import "ZLDeviceSelectedTitleView.h"
#import "ZLDeviceSelectedHeaderView.h"
#import "ZLDeviceSelectedFooterView.h"
#import "ZLDeviceSelectedViewCell.h"
#import "ZLDeviceSlectedViewConst.h"
#import "ZLDeviceSelectedViewModel.h"
#import "ZLDeviceChoiseModel.h"
#import "Masonry.h"

static CGFloat const headerHeight = 60.f;
static CGFloat const titleFooterHeight = 50.f;
static NSString *cellID = @"ZLDeviceSelectedViewCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ZLDeviceSelectedHeaderDelegate>

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger preSection;

@property (nonatomic, assign) CGFloat tableViewOriginHeight;

@end

@implementation ViewController

- (NSArray *)titleArray {
    if (nil == _titleArray) {
        ;
        _titleArray = @[
                        [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_NFC_nor", @"selectedImage" : @"btn_NFC_pre", @"title" : @"手机内置NFC", @"canChoice" : @"NO",@"vendor":@[
                                                                           [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                           [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}]
                                                                      ]
                                                              }],
                        [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_BT_nor", @"selectedImage" : @"btn_BT_pre", @"title" : @"蓝牙接入读头", @"canChoice" : @"YES", @"vendor":@[
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}]
                                                                      ]
                                                              }],
                        [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_OTG_nor", @"selectedImage" : @"btn_OTG_pre", @"title" : @"OTG接入读头", @"canChoice" : @"YES", @"vendor":@[
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"测试"}],
                                                                      [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"第二"}]]
                                                                   }]
                        ];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kRGBColorFromHex(0xE5F7FA);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view);
                make.width.equalTo(self.view).multipliedBy(0.7);
        self.tableViewOriginHeight = headerHeight * 3 + titleFooterHeight * 2;
                make.height.mas_equalTo(self.tableViewOriginHeight);
        make.top.equalTo(self.view).offset(([[UIScreen mainScreen] bounds].size.height - self.tableViewOriginHeight) / 2);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.preSection = -1;
    
    
    ZLDeviceSelectedTitleView *titleView = [[ZLDeviceSelectedTitleView alloc] init];
    titleView.title = @"123";
    titleView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, titleFooterHeight);
    self.tableView.tableHeaderView = titleView;
    
    ZLDeviceSelectedFooterView *footerView = [[ZLDeviceSelectedFooterView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, titleFooterHeight);
    self.tableView.tableFooterView = footerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZLDeviceSelectedViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZLDeviceSelectedViewModel *model = self.titleArray[section];
    if (self.preSection == model.section) {
        return model.isSelected ? 1 : 0;
    } else {
        model.selected = NO;
        return 0;
    }
}

- (IBAction)btnDidClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZLDeviceSelectedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    ZLDeviceSelectedViewModel *headerModel = self.titleArray[indexPath.section];
    cell.model = headerModel;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZLDeviceSelectedViewModel *model = self.titleArray[section];
    model.section = section;
    model.currentSelectedDeviceIndex = 0;
    ZLDeviceSelectedHeaderView *header = [ZLDeviceSelectedHeaderView sectionHeader];
    header.model = model;
    header.delegate = self;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZLDeviceSelectedViewModel *model = self.titleArray[indexPath.section];
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
        preModel = self.titleArray[self.preSection];
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
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    [self.tableView  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset( selected ? (self.tableViewOriginHeight + sectionHeader.model.cellHeight) : self.tableViewOriginHeight);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView setNeedsLayout];
        [self.tableView layoutIfNeeded];
    }];
}


@end
