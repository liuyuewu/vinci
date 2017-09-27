//
//  ViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 17/6/21.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "ViewController.h"

#import "ScanLAN.h"
#import "IPDetector.h"

@interface ViewController () <ScanLANDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getWlanWifi];
    [self deepScanWlan];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getWlanWifi{
    [self detectMySelf];
    
    if ([IPDetector getWifiStatus]) {
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"提示:" message:@"请打开链接wifi" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

- (void)deepScanWlan{
    if ([IPDetector getWifiStatus]) {
        ScanLAN *scan = [[ScanLAN alloc] initWithDelegate:self];
        [scan startScan];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"提示:" message:@"请打开链接wifi" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

- (void)detectMySelf {
    [IPDetector getLANIPAddressWithCompletion:^(NSString *IPAddress) {
        if ([IPAddress isEqualToString:@"error"]) {
            IPAddress = @"获取不到当前设备局域网IP";
        }
    }];
}


#pragma mark - UtilDelegate

- (void)utilScanLANDidFindNewAdrress:(NSString *)address havingMactName:(NSString *)macName{
    if ([macName isEqualToString:@"00:00:00:00:00:00"]) {
        return;
    }
    
    NSLog(@"new scan address = %@ mac name = %@",address,macName);
}

- (void)utilScanLandidFinishScanning{
    NSLog(@"scan finish...");
}

#pragma mark - ScanLANDelegate

- (void)scanLANDidFindNewAdrress:(NSString *)address havingHostName:(NSString *)hostName{
    NSLog(@"find scan address = %@ host name = %@",address,hostName);
}

- (void)scanLANDidFinishScanning{
    __weak typeof(self) weakSelf = self;
    [weakSelf getWlanWifi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
