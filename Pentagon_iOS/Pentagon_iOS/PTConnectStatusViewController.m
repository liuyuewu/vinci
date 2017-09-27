//
//  PTConnectStatusViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTConnectStatusViewController.h"
#import "PTConnectProgressView.h"
#import "PTChooseWiFIViewController.h"
#import "PTConnectViewController.h"
#import "PTWiFiHandler.h"
#import "AFHTTPSessionManager.h"
#import <JQFMDB.h>
#import "PTWifiModel.h"
#import "AppDelegate.h"
#import "PTConnectWiFiViewController.h"
#import "BluetoothManager.h"

@interface PTConnectStatusViewController ()

@property (strong, nonatomic) UIImageView *titleImageView;

@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) PTConnectProgressView *progressView;
@property (strong, nonatomic) UILabel *pushLabel;
@property (strong, nonatomic) JQFMDB *db;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) BOOL canJudge;


@end

@implementation PTConnectStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    self.db = [JQFMDB shareDatabase];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.pushLabel];
    self.canJudge = NO;
    
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(method) userInfo:nil repeats:NO];
    
//    [self connect];  //fire base 连接
    
    [self connectWifiBlouth];

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveSnapData:) name:@"PTReceiveSnapDataNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bluetoothReceiveData:) name:PDBabyBlueToothNofification object:nil];

    
    // Do any additional setup after loading the view.
}

- (void)setupNavigation{
    [self.customNav addSubview:self.titleImageView];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PDBabyBlueToothNofification object:nil];
}

#pragma mark - 蓝牙处理逻辑

-(void)bluetoothReceiveData:(NSNotification *)noti{
    
    debugLog(@"收到蓝牙通知");
    [self.navigationController popViewControllerAnimated:YES];
    return;
    
    NSString *reStr = (NSString *)noti.object;
    
    if (reStr.length != 4) {
        
        return;
    }
    
    if ([reStr characterAtIndex:0] == 'F' || [reStr characterAtIndex:0] == 'f')
    {
        //
        
        if ([reStr characterAtIndex:1] == 'A' || [reStr characterAtIndex:1] == 'a')
        {
            //网络
            
            if ([reStr characterAtIndex:3] == '1')
            {
                //成功
                
//                NSString *headSetID = [dict objectForKey:@"headset_id"];
                
                [self.view makeToast:@"连接成功" duration:2.0f position:CSToastPositionCenter];
                [self.timer invalidate];
                [self.progressView resume];
                
//                [NSUserDefaults yn_setObject:@"true" forKey:PTConnectWifiKey];
                
//                [NSUserDefaults yn_setObject:headSetID forKey:PTGoogleHeaderIDKey];
                
                PTWifiModel *model = [[PTWifiModel alloc]init];
                model.ssid = self.wifiName;
                model.password = self.wifiPassword;
                model.mac = [PTWiFiHandler currentMACAddress];
//                model.headsetID = headSetID;
                
                [self removeAllKey];
                
                [self.db jq_deleteAllDataFromTable:@"wifi"];
                
                
                
//                if ([self.db jq_lookupTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"ssid IS NOT NULL"]].count) {
//
//                }
                
                [self.db jq_insertTable:@"wifi" dicOrModel:model];

                
                
//                
//                if ([self.db jq_lookupTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"headsetID = '%@'",headSetID]].count != 0) {
//                    [self.db jq_updateTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"headsetID = '%@",headSetID]];
//                }else{
//                    
//                    [self.db jq_insertTable:@"wifi" dicOrModel:model];
//                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    PTConnectViewController *vc = [[PTConnectViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                });

                
                
            }else{
                
                [self.view makeToast:@"蓝牙返回失败" duration:2.0f position:CSToastPositionCenter];

            }
        }
        
    }
    
    
    
    
    
    
    
    return;
    
    NSDictionary *dict = noti.object;
    
    
    
    
    if ([[dict objectForKey:@"type"] isEqualToString:@"wifi"])
    {
        if ([[dict objectForKey:@"status"] integerValue] == 200) {
            
            debugLog(@"蓝牙连接成功");
            
            NSString *headSetID = [dict objectForKey:@"headset_id"];
            
            [self.view makeToast:@"连接成功" duration:2.0f position:CSToastPositionCenter];
            [self.timer invalidate];
            [self.progressView resume];
            
            [NSUserDefaults yn_setBool:true forKey:PTConnectWifiKey];
            
            
            [NSUserDefaults yn_setObject:headSetID forKey:PTGoogleHeaderIDKey];
            
            PTWifiModel *model = [[PTWifiModel alloc]init];
            model.ssid = self.wifiName;
            model.password = self.wifiPassword;
            model.mac = [PTWiFiHandler currentMACAddress];
            model.headsetID = headSetID;
            
            [self removeAllKey];
            
            if ([self.db jq_lookupTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"headsetID = '%@'",headSetID]].count != 0) {
                [self.db jq_updateTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"headsetID = '%@",headSetID]];
            }else{
                
                [self.db jq_insertTable:@"wifi" dicOrModel:model];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                PTConnectViewController *vc = [[PTConnectViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            });

        }else{
            
            [NSUserDefaults yn_setBool:false forKey:PTConnectWifiKey];

            
            [self.view makeToast:@"蓝牙返回失败" duration:2.0f position:CSToastPositionCenter];

        }
    }

    
}



#pragma mark - fireBase 逻辑


- (void)receiveSnapData:(NSNotification *)noti{
    NSDictionary *dict = noti.object;
    NSLog(@"FireBase snap not change shot value= %@",dict);
    if (dict && ![dict isKindOfClass:[NSNull class]]) {
        if ([dict[@"headset_id"] isEqualToString:[NSUserDefaults yn_stringForKey:PTGoogleHeaderIDKey]]) {
            if (dict[@"isconfig"] == [NSNumber numberWithInteger:1]) {
                [self updateValue:dict];
            }
        }
    }

}

- (void)updateValue:(NSDictionary *)data{
    
    NSString *headsetID = [NSUserDefaults yn_stringForKey:PTGoogleHeaderIDKey];
    
    NSDictionary *notiDic = (NSDictionary *)data;
    
    if ([notiDic[@"headset_id"] isEqualToString:headsetID]) {

        NSString *headSetID = [notiDic objectForKey:@"headset_id"];
        NSString *isconfig = [NSString stringWithFormat:@"%@",[notiDic objectForKey:@"isconfig"]];
        
        if ([isconfig isEqualToString:@"1"]) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            [self.view makeToast:@"连接成功" duration:2.0f position:CSToastPositionCenter];
            [self.timer invalidate];
            [self.progressView resume];
            
            [NSUserDefaults yn_setObject:@"true" forKey:PTConnectWifiKey];
            [NSUserDefaults yn_setObject:headSetID forKey:PTGoogleHeaderIDKey];
            
            PTWifiModel *model = [[PTWifiModel alloc]init];
            model.ssid = self.wifiName;
            model.password = self.wifiPassword;
            model.mac = [PTWiFiHandler currentMACAddress];
            model.headsetID = headSetID;
            
            
            [self removeAllKey];
            
            if ([self.db jq_lookupTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"headsetID = '%@'",headSetID]].count != 0) {
                [self.db jq_updateTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"headsetID = '%@",headSetID]];
            }else{
                
                [self.db jq_insertTable:@"wifi" dicOrModel:model];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                PTConnectViewController *vc = [[PTConnectViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            });
        }else{
            
        }
    }else{
    
    }

}

-(void)connectWifiBlouth{
    
    //蓝牙传输
    
    [self.progressView startConnect];

    
    NSDictionary *dict = @{@"t": @"w",@"s":self.wifiName,@"p":self.wifiPassword};
    
    NSString *jsonStr = [dict mj_JSONString];
    
    NSString *base64Str = [jsonStr base64EncodedString];

    
    
    BluetoothManager *manager = [BluetoothManager shareInstance];
    
    [manager sendValue:base64Str];
    
}

- (void)connect{
    
    //网络更新
    [self.progressView startConnect];
    
    NSString *ip = [PTWiFiHandler currentHostIP];
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:8081",ip];
    NSDictionary *dict = @{@"ssid":self.wifiName,@"password":self.wifiPassword};

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json", nil];

    [manager GET:urlStr parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"request success = %@",responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSLog(@"headersetID = %@",dict[@"headset_id"]);
        [NSUserDefaults yn_setObject:dict[@"headset_id"] forKey:PTGoogleHeaderIDKey];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (self.connectErrorBlock) {
            self.connectErrorBlock();
        }
        
        NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];

        for (UIViewController *controller in navigationArray) {
            if ([controller isKindOfClass:[PTConnectWiFiViewController class]]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"PTConnectPentagonErrorNotification" object:nil];
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
        NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
        NSLog(@"error = %@ code = %lu",[error localizedDescription],responses.statusCode);
        NSLog(@"response header = %@",responses.allHeaderFields);
    }];

    NSLog(@"current ip = %@ host ip = %@",[PTWiFiHandler currentIP],[PTWiFiHandler currentHostIP]);

    
}

- (void)method{
    [self.timer invalidate];
    if (self.connectErrorBlock) {
        self.connectErrorBlock();
    }
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    for (UIViewController *controller in navigationArray) {
        if ([controller isKindOfClass:[PTConnectWiFiViewController class]]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"PTConnectPentagonErrorNotification" object:nil];
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(__NAVIGATION_BAR_HEIGHT);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.pushLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-SP(30));
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
}

#pragma mark - Private method

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushAction{
    PTConnectViewController *vc = [[PTConnectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Property

- (UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleImageView.image = [UIImage imageNamed:@"icon_pentagon_3"];
    }
    return _titleImageView;
}

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SP(31), __NAVIGATION_BAR_HEIGHT + SP(22), __SCREEN_WIDTH - 2*SP(31), SP(25))];
        _noticeLabel.font = [UIFont systemFontOfSize:SP(18)];
        _noticeLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _noticeLabel.text = @"Preparing your Pentagon";
    }
    return _noticeLabel;
}

- (PTConnectProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[PTConnectProgressView alloc]init];
    }
    return _progressView;
}

- (UILabel *)pushLabel{
    if (!_pushLabel) {
        _pushLabel = [[UILabel alloc]init];
        _pushLabel.font = K_Font_02;
        _pushLabel.textAlignment = NSTextAlignmentCenter;
        _pushLabel.textColor = K_Color_05;
        _pushLabel.userInteractionEnabled = YES;
        _pushLabel.numberOfLines = 0;
        _pushLabel.text = @"Pentagon wifi have connected ? \nClick this to skip";
        @WeakObj(self);
        [_pushLabel yn_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            @StrongObj(self);
            [self pushAction];
        }];
    }
    return _pushLabel;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
