//
//  DNSwiftProjectTests-Bridging-Header.h
//  DNSwiftProject
//
//  Created by mainone on 16/12/14.
//  Copyright © 2016年 wjn. All rights reserved.
//

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

// MD5加密
#import <CommonCrypto/CommonCrypto.h>
