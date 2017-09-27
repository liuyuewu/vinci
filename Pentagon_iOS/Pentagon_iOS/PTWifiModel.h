//
//  PTWifiModel.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/28.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBaseModel.h"

@interface PTWifiModel : PTBaseModel

@property (strong, nonatomic) NSString *mac;
@property (strong, nonatomic) NSString *ip;
@property (strong, nonatomic) NSString *ssid;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *headsetID;

@end
