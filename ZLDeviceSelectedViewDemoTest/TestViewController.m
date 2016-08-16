//
//  TestViewController.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/12.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "TestViewController.h"
#import "ZLDeviceSelectedView.h"
#import "ZLDeviceSelectedViewModel.h"
#import "ZLDeviceChoiseModel.h"
#import "Masonry.h"

@interface TestViewController ()

@end

@implementation TestViewController
- (IBAction)twoDidClick:(id)sender {
    NSArray *array = @[
                       [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_NFC_nor", @"selectedImage" : @"btn_NFC_pre", @"title" : @"手机内置NFC", @"tipsWhenHasNoneDevice" : @"暂不支持NFC模式"
                                                                  }],
                       [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_BT_nor", @"selectedImage" : @"btn_BT_pre", @"title" : @"蓝牙接入读头", @"vendor":@[
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}],
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}],
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}],
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"信通"}],
                                                                          [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"森锐"}]
                                                                          ]
                                                                  }]
                       ];
    [[ZLDeviceSelectedView deviceSelectedViewWithTitle:@"请输入" detailArray:array storeKey:@"SimCardWrite" selectedDeviceResult:^(NSDictionary *result) {
        NSLog(@"%@", result);
    }] show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)buttonDidClick:(id)sender {
     NSArray *detailArray = @[
                              [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_NFC_nor", @"selectedImage" : @"btn_NFC_pre", @"title" : @"手机内置NFC", @"tipsWhenHasNoneDevice" : @"暂不支持NFC模式"
                                                                         }],
                              [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_BT_nor", @"selectedImage" : @"btn_BT_pre", @"title" : @"蓝牙接入读头", @"vendor":@[
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
                              [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_OTG_nor", @"selectedImage" : @"btn_OTG_pre", @"title" : @"OTG接入读头",@"vendor":@[
                                                                                 [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"测试"}],
                                                                                 [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"第二"}]
                                                                                 ]
                                                                         }]
                              ];
    [[ZLDeviceSelectedView deviceSelectedViewWithTitle:@"请选择设备" detailArray:detailArray storeKey:@"IDCardRead" selectedDeviceResult:^(NSDictionary *result) {
        
    }] show];
//    [deviceView show];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
