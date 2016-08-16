# ZLDeviceSelectedView

---
You can use `ZLDeviceSelectedView` to choise the device which you selected.If you hanve any advice or problem, please [issue](https://github.com/sunnyzl/ZLDeviceSelectedView/issues) me.

# Usage

---
### step one
First, you should import `ZLDeviceSelectedViewModel.h`, `ZLDeviceChoiseModel.h` and `ZLDeviceSelectedView.h`.

### step two
Second, you should init a `NSArray` to set up the `detailArray`, and use the initial method to create and use it.

```
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
    
    [[ZLDeviceSelectedView deviceSelectedViewWithTitle:@"Please choise the device of read ID Card" detailArray:detailArray storeKey:@"IDCardRead" selectedDeviceResult:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
    }] show];
    
```
and you can assign the value like this

```
NSArray *detailArray = @[
                             [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_NFC_nor", @"selectedImage" : @"btn_NFC_pre", @"title" : @"NFC device", @"tipsWhenHasNoneDevice" : @"Temporarily dose not support NFC mode"
                                                                        }],
                             [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_BT_nor", @"selectedImage" : @"btn_BT_pre", @"title" : @"Bluetooth device", @"vendor":@[
                                                                                [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"1", @"vendorName":@"NFC1"}],
                                                                                [ZLDeviceChoiseModel modelWithDict:@{@"vendorNumber":@"2", @"vendorName":@"NFC2"}]
                                                                                ]
                                                                        }],
                             [ZLDeviceSelectedViewModel modelWithDict:@{@"normalImage" : @"btn_OTG_nor", @"selectedImage" : @"btn_OTG_pre", @"title" : @"OTG device", @"tipsWhenHasNoneDevice" : @"Temporarily dose not support NFC mode"
                                                                        }]
                             ];
    
    [[ZLDeviceSelectedView deviceSelectedViewWithTitle:@"Please choise the device of read ID Card" detailArray:detailArray storeKey:@"IDCardRead" selectedDeviceResult:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
    }] show];

```

You can use it like this, then you should not assign the modelArray everytime when you use it.Because it is too long ,and you maybe make a mistake when you write it.So I think we can encapsulate it in a singleton method, just like the `ManageTools` I used in here.

```
[ManageTools idCardDeviceSelectedView:^(NSDictionary *result) {
        NSLog(@"result: %@", result);
    }];

```

### Note

```
The class `ZLDeviceChoiseModle` which I encapsulate may not satisfy your requirement. You can modify it.And you should modify the code at some files.

1.In `ZLDeviceChoiseModle.h`
2.In `ZLDeviceSelectedView` at line 318 and 319
3.In `ZLDeviceSelectedDeviceContentView.h` at line 80
4.In `ZLDeviceSelectedDeviceView.h` at line 58
5.And you shoud modify the value when you assign the `detailArray`
```