//
//  PTWiFiHandler.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTWiFiHandler : NSObject

+ (NSString *)currentSSID;
+ (NSString *)currentMACAddress;
+ (NSString *)currentIP;
+ (NSString *)currentHostIP;

+ (void)getWifiList;
+ (void)scanWifiInfos;
@end
