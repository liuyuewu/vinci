//
//  PTConnectStatusViewController.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBaseViewController.h"

@interface PTConnectStatusViewController : PTBaseViewController

@property (strong, nonatomic) NSString *wifiName;
@property (strong, nonatomic) NSString *wifiPassword;
@property (copy, nonatomic) void (^connectErrorBlock)();
@end
