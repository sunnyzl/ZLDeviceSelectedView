//
//  ManageTools.m
//  ZLDeviceSelectedViewDemoTest
//
//  Created by zhaoliang on 16/8/16.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ManageTools.h"
#import "ZLDeviceChoiseModel.h"
#import "ZLDeviceSelectedViewModel.h"
#import "ZLDeviceSelectedView.h"

@interface ManageTools ()

@end

@implementation ManageTools

+ (instancetype)sharedInstance {
    static ManageTools *manageTools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manageTools = [[[self class] alloc]  init];
    });
    return manageTools;
}

+ (void)idCardDeviceSelectedView:(void (^)(NSDictionary *result))result {
    
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
    
    [[ZLDeviceSelectedView deviceSelectedViewWithTitle:@"Please choise the device of read ID Card" detailArray:detailArray storeKey:@"IDCardRead" selectedDeviceResult:result] show];
}

+ (void)simCardDeviceSelectedView:(void (^)(NSDictionary *result))result {
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:8];
    for (NSInteger index = 0; index < 8; index++) {
        ZLDeviceChoiseModel *deviceChoiceModel = [[ZLDeviceChoiseModel alloc] init];
        deviceChoiceModel.vendorNumber = [NSString stringWithFormat:@"%ld", index];
        deviceChoiceModel.vendorName = [NSString stringWithFormat:@"Bluetooth%ld", index];
        [modelArray addObject:deviceChoiceModel];
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
        model.vendor = modelArray;
        model;
    });
    
    NSArray *array = @[nfcModel, bluetoothModel];
    [[ZLDeviceSelectedView deviceSelectedViewWithTitle:@"Please choise the write card device" detailArray:array storeKey:@"SimCardWrite" selectedDeviceResult:result] show];
}

@end
