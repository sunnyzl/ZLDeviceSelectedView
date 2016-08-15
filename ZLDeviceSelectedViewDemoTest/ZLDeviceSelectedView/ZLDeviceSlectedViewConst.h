//
//  ZLDeviceSlectedViewConst.h
//  ZLDeviceSelectedViewDemo
//
//  Created by zhaoliang on 16/8/10.
//  Copyright © 2016年 zhao. All rights reserved.
//

#ifndef ZLDeviceSlectedViewConst_h
#define ZLDeviceSlectedViewConst_h

#import <Availability.h>

#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#ifdef __OBJC__

#define ZLKeyPath(key,value) (@(((void)(key.value), (#value))))
#define kRGBColor(R, G, B)          [UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:1.0]
#define kRGBAColor(R, G, B, A)      [UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:(A)]
#define kRGBColorFromHex(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0f \
blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]


#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self

#define ZLDeviceSelectedDeviceViewNotification (@"ZLDeviceSelectedDeviceViewNotification")
#define ZLDeviceSelectedDeviceViewDeviceModel (@"ZLDeviceSelectedDeviceViewDeviceModel")
#define ZLDeviceSelectedDeviceViewDeviceIndexPath (@"ZLDeviceSelectedDeviceViewDeviceIndexPath")

#define ZLDeviceSelectedDeviceViewSelectedSection(storedKey) ([NSString stringWithFormat:@"ZLDeviceSelectedDeviceViewSelectedSection%@", (storedKey) ? (storedKey) : @""])
#define ZLDeviceSelectedDeviceViewSelectedRow(storedKey) ([NSString stringWithFormat:@"ZLDeviceSelectedDeviceViewSelectedRow%@", (storedKey) ? (storedKey) : @""])
#define ZLDeviceSelectedDeviceViewHeight (@"ZLDeviceSelectedDeviceViewHeight")

#endif

#endif /* ZLDeviceSlectedViewConst_h */
