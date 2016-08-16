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
#import "ManageTools.h"
#import "Masonry.h"

@interface TestViewController ()

@end

@implementation TestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)buttonDidClick:(id)sender {
    /*
    NSMutableArray *bluetoothModelArray = [NSMutableArray arrayWithCapacity:8];
    for (NSInteger index = 0; index < 8; index++) {
        ZLDeviceChoiseModel *deviceChoiceModel = [[ZLDeviceChoiseModel alloc] init];
        deviceChoiceModel.vendorNumber = [NSString stringWithFormat:@"%ld", index];
        deviceChoiceModel.vendorName = [NSString stringWithFormat:@"Bluetooth%ld", index];
        [bluetoothModelArray addObject:deviceChoiceModel];
    }
    
    NSMutableArray *otgModelArray = [NSMutableArray arrayWithCapacity:2];
    for (NSInteger index = 0; index < 2; index++) {
        ZLDeviceChoiseModel *deviceChoiceModel = [[ZLDeviceChoiseModel alloc] init];
        deviceChoiceModel.vendorNumber = [@(index) stringValue];
        deviceChoiceModel.vendorName = [NSString stringWithFormat:@"OGT%ld", index];
        [otgModelArray addObject:deviceChoiceModel];
    }
    
    
    ZLDeviceSelectedViewModel *nfcModel = ({
        ZLDeviceSelectedViewModel *model = [[ZLDeviceSelectedViewModel alloc] init];
        model.normalImage = @"btn_NFC_nor";
        model.selectedImage = @"btn_NFC_pre";
        model.title = @"NFC device";
        model.tipsWhenHasNoneDevice = @"Temporarily dose not support NFC mode";
        model;
    });
    ZLDeviceSelectedViewModel *bluetoothModel = ({
        ZLDeviceSelectedViewModel *model = [[ZLDeviceSelectedViewModel alloc] init];
        model.normalImage = @"btn_BT_nor";
        model.selectedImage = @"btn_BT_pre";
        model.title = @"Bluetooth device";
        model.vendor = bluetoothModelArray;
        model;
    });
    ZLDeviceSelectedViewModel *otgModel = ({
        ZLDeviceSelectedViewModel *model = [[ZLDeviceSelectedViewModel alloc] init];
        model.normalImage = @"btn_OTG_nor";
        model.selectedImage = @"btn_OTG_pre";
        model.title = @"OTG device";
        model.vendor = otgModelArray;
        model;
    });
    NSArray *detailArray = @[nfcModel, bluetoothModel, otgModel];
    //  you can assignment like this
    
//    NSArray *detailArray = @[
//                             [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_NFC_nor", @"selectedImage" : @"btn_NFC_pre", @"title" : @"NFC device", @"tipsWhenHasNoneDevice" : @"Temporarily dose not support NFC mode"
//                                                                        }],
//                             [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_BT_nor", @"selectedImage" : @"btn_BT_pre", @"title" : @"Bluetooth device", @"vendor":@[
//                                                                                [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"NFC1"}],
//                                                                                [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"NFC2"}]
//                                                                                ]
//                                                                        }],
//                             [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_OTG_nor", @"selectedImage" : @"btn_OTG_pre", @"title" : @"OTG device", @"tipsWhenHasNoneDevice" : @"Temporarily dose not support NFC mode"
//                                                                        }]
//                             ];
//    
//    [[ZLDeviceSelectedView deviceSelectedViewWithTitle:@"Please choise the device of read ID Card" detailArray:detailArray storeKey:@"IDCardRead" selectedDeviceResult:^(NSDictionary *result) {
//        NSLog(@"result: %@", result);
//    }] show];
     */
    //  you can use it like this, then you should not assign the modelArray everytime when you use it.Because it is too long ,and you maybe make a mistake when you write it.So I think we can encapsulate it in a singleton method, just like the `ManageTools` I used in here.
    
    [ManageTools idCardDeviceSelectedView:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
    }];
    
    
}
- (IBAction)twoDidClick:(id)sender {
    [ManageTools simCardDeviceSelectedView:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
    }];
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
