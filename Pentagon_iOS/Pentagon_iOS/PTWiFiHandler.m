//
//  PTWiFiHandler.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTWiFiHandler.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>

#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation PTWiFiHandler

+ (NSString *)currentSSID{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = CFBridgingRelease(CNCopyCurrentNetworkInfo((CFStringRef)ifname));
        if (info && [info count]) {
            break;
        }
    }

    NSDictionary *dic = (NSDictionary *)info;
    NSString *ssid = [[dic objectForKey:@"SSID"]lowercaseString];
    return ssid;
}

+ (NSString *)currentMACAddress{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = CFBridgingRelease(CNCopyCurrentNetworkInfo((CFStringRef)ifname));
        if (info && [info count]) {
            break;
        }
    }
    
    NSDictionary *dic = (NSDictionary *)info;
    NSLog(@"dic = %@",dic);
    NSString *bssid = [[dic objectForKey:@"BSSID"]lowercaseString];
    return bssid;
}

+ (NSString *)currentIP{
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)currentHostIP{
    NSString *ip = [PTWiFiHandler currentIP];
    NSArray *ipArray = [ip componentsSeparatedByString:@"."];
    NSString *hostIP = [NSString stringWithFormat:@"%@.%@.%@.%@",ipArray[0],ipArray[1],ipArray[2],@"1"];
    return hostIP;
}

+ (void)getWifiList{
        NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
        [options setObject:@"🔑😀新网程-点我上网😀🔑" forKey:kNEHotspotHelperOptionDisplayName];
        
        dispatch_queue_t queue = dispatch_queue_create("com.pronetwayXY", NULL);
        BOOL returnType = [NEHotspotHelper registerWithOptions:options queue:queue handler: ^(NEHotspotHelperCommand * cmd) {
            NEHotspotNetwork* network;
            NSLog(@"COMMAND TYPE:   %ld", (long)cmd.commandType);
            [cmd createResponse:kNEHotspotHelperResultAuthenticationRequired];
            if (cmd.commandType == kNEHotspotHelperCommandTypeEvaluate || cmd.commandType ==kNEHotspotHelperCommandTypeFilterScanList) {
                NSLog(@"WIFILIST:   %@", cmd.networkList);
                for (network  in cmd.networkList) {
                    // NSLog(@"COMMAND TYPE After:   %ld", (long)cmd.commandType);
                    if ([network.SSID isEqualToString:@"ssid"]|| [network.SSID isEqualToString:@"proict_test"]) {
                        
                        double signalStrength = network.signalStrength;
                        NSLog(@"Signal Strength: %f", signalStrength);
                        [network setConfidence:kNEHotspotHelperConfidenceHigh];
                        [network setPassword:@"password"];
                        
                        NEHotspotHelperResponse *response = [cmd createResponse:kNEHotspotHelperResultSuccess];
                        NSLog(@"Response CMD %@", response);
                        
                        [response setNetworkList:@[network]];
                        [response setNetwork:network];
                        [response deliver];
                    }
                }
            }
        }];
        NSLog(@"result :%d", returnType);
        NSArray *array = [NEHotspotHelper supportedNetworkInterfaces];
        NSLog(@"wifiArray:%@", array);
        NEHotspotNetwork *connectedNetwork = [array lastObject];
        NSLog(@"supported Network Interface: %@", connectedNetwork);
}

+ (void)scanWifiInfos{
    NSLog(@"1.Start");
    
    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    [options setObject:@"EFNEHotspotHelperDemo" forKey: kNEHotspotHelperOptionDisplayName];
    dispatch_queue_t queue = dispatch_queue_create("EFNEHotspotHelperDemo", NULL);
    
    NSLog(@"2.Try");
    BOOL returnType = [NEHotspotHelper registerWithOptions: options queue: queue handler: ^(NEHotspotHelperCommand * cmd) {
        
        NSLog(@"4.Finish");
        NEHotspotNetwork* network;
        if (cmd.commandType == kNEHotspotHelperCommandTypeEvaluate || cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList) {
            // 遍历 WiFi 列表，打印基本信息
            for (network in cmd.networkList) {
                NSString* wifiInfoString = [[NSString alloc] initWithFormat: @"---------------------------\nSSID: %@\nMac地址: %@\n信号强度: %f\nCommandType:%ld\n---------------------------\n\n", network.SSID, network.BSSID, network.signalStrength, (long)cmd.commandType];
                NSLog(@"%@", wifiInfoString);
                
                // 检测到指定 WiFi 可设定密码直接连接
                if ([network.SSID isEqualToString: @"测试 WiFi"]) {
                    [network setConfidence: kNEHotspotHelperConfidenceHigh];
                    [network setPassword: @"123456789"];
                    NEHotspotHelperResponse *response = [cmd createResponse: kNEHotspotHelperResultSuccess];
                    NSLog(@"Response CMD: %@", response);
                    [response setNetworkList: @[network]];
                    [response setNetwork: network];
                    [response deliver];
                }
            }
        }
    }];
    
    // 注册成功 returnType 会返回一个 Yes 值，否则 No
    NSLog(@"3.Result: %@", returnType == YES ? @"Yes" : @"No");
}



@end
