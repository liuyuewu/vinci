//
//  PTBodyConnectView.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBodyConnectView.h"
#import "PTButton.h"
#import "PTWiFiHandler.h"

#import "PTBeginConnectViewController.h"
#import "PTMusicServiceViewController.h"
#import "PTAlertView.h"
#import "PTWifiModel.h"
#import <JQFMDB.h>

@interface PTBodyConnectView () <UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) PTButton *musicButton;
@property (strong, nonatomic) UILabel *bottomLabel;

@property (strong, nonatomic) UILabel *netLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) MFTextField *wifiNameTextField;
@property (strong, nonatomic) MFTextField *wifiPasswordTextField;


@property (nonatomic, retain) PTWifiModel *wifiModel;



@end

@implementation PTBodyConnectView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.bodyLabel];
        [self addSubview:self.musicButton];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.netLabel];
        [self addSubview:self.passwordLabel];
        [self addSubview:self.wifiNameTextField];
        [self addSubview:self.wifiPasswordTextField];
        
        
        NSString *headerSetId = [NSUserDefaults yn_stringForKey:PTGoogleHeaderIDKey];
        
        if (headerSetId && headerSetId.length > 0)
        {
            NSArray *dataArr =  [[JQFMDB shareDatabase] jq_lookupTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"where headsetID = '%@'",headerSetId]];
            
            if (dataArr.count > 0)
            {
                _wifiModel = dataArr.firstObject;
                
                _wifiNameTextField.text = _wifiModel.ssid;
            }

        }
        
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(SP(24));
    }];
    
    [self.netLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wifiNameTextField.mas_centerY);
        make.right.equalTo(self.wifiNameTextField.mas_centerX).offset(-6);
    }];
    
    [self.wifiNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(15));
        make.right.equalTo(self.mas_right).offset(-SP(15));
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(SP(24));
        make.height.mas_equalTo(SP(45));
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wifiPasswordTextField.mas_centerY);
        make.centerX.equalTo(self.netLabel.mas_centerX);
    }];
    
    [self.wifiPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(15));
        make.right.equalTo(self.mas_right).offset(-SP(15));
        make.top.equalTo(self.wifiNameTextField.mas_bottom).offset(6);
        make.height.mas_equalTo(SP(45));
    }];
    
    [self.musicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(50));
        make.right.equalTo(self.mas_right).offset(-SP(50));
        make.height.mas_equalTo(45);
        make.bottom.equalTo(self.mas_bottom).offset(-SP(72));
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(20));
        make.bottom.equalTo(self.mas_bottom).offset(-37);
        make.right.equalTo(self.mas_right).offset(-SP(20));
    }];
}

#pragma mark - Private method

- (void)musicServiceAction:(UIButton *)button{
    if (self.musicServiceBlock) {
        self.musicServiceBlock();
    }
}

- (void)chooseNetworkAction:(UIButton *)button{
    if (self.chooseNetworkBlock) {
        self.chooseNetworkBlock();
    }
}

- (void)updateData{
    NSString *section = [NSUserDefaults yn_stringForKey:@"selectMusicService"];
    
    if ([section isEqualToString:@"0"]) {
        self.wifiPasswordTextField.text = @"Spotify";
    }else{
        self.wifiPasswordTextField.text = @"Amazon Alexa";
    }
    
}

- (BOOL)isLoginInSpotify{
    if (![NSUserDefaults yn_stringForKey:PTSpotifyAccessToken] || [[NSUserDefaults yn_stringForKey:PTSpotifyAccessToken] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (BOOL)isLoginInAlexa{
    if (![NSUserDefaults yn_stringForKey:PTAlexaAccessToken] || [[NSUserDefaults yn_stringForKey:PTAlexaAccessToken] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}


#pragma mark - Property

- (void)setConnectStatus:(ConnectStatus)connectStatus{
    _connectStatus = connectStatus;
    switch (_connectStatus) {
        case WifiOnlyConnectStatus:
        {
            self.wifiNameTextField.text = _wifiModel.ssid;
            self.wifiPasswordTextField.hidden = YES;
            self.musicButton.hidden = NO;
        }
            break;
        case WifiAndMusicServiceStatus:
        {
            [self updateData];
            [self setupViews];
            self.wifiPasswordTextField.hidden = NO;
            self.musicButton.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)setupViews{
    [self.netLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wifiNameTextField.mas_centerY);
        make.left.equalTo(self.wifiNameTextField.mas_left);
    }];
    
    [self.wifiNameTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(15));
        make.right.equalTo(self.mas_right).offset(-SP(15));
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(SP(24));
        make.height.mas_equalTo(SP(45));
    }];
    
    [self.passwordLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wifiPasswordTextField.mas_centerY);
        make.left.equalTo(self.wifiPasswordTextField.mas_left);
    }];
    
    [self.wifiPasswordTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(15));
        make.right.equalTo(self.mas_right).offset(-SP(15));
        make.top.equalTo(self.wifiNameTextField.mas_bottom).offset(6);
        make.height.mas_equalTo(SP(45));
    }];
    
    self.wifiNameTextField.leftTextOffset = SP(60);
    self.wifiPasswordTextField.leftTextOffset = SP(93);
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (textField == self.wifiNameTextField) {
//        PTAlertView *alert = [PTAlertView alertView];
//        alert.alertType = PTNoticeAlertView;
//        alert.message = @"You want to choose a different network?";
//        
//        @WeakObj(self);
//        alert.completeBlock = ^{
//            @StrongObj(self);
//            [self changeDifferentDevice];
//        };
//        [alert show];
//    }else{
//        PTMusicServiceViewController *vc = [[PTMusicServiceViewController alloc]init];
//        [self.yn_viewController.navigationController pushViewController:vc animated:YES];
//    }
    
//    return NO;
//}

//- (void)changeDifferentDevice{
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a=[dat timeIntervalSince1970];
//    
//    //清除授权
//    NSString *headsetID = [NSUserDefaults yn_stringForKey:PTGoogleHeaderIDKey];
//    NSLog(@"head set id = %@",headsetID);
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    hud.label.text = @"waiting";
//    [[[self.ref child:@"headwificonfigs"]child:headsetID]setValue:@{@"headset_id":headsetID,@"timestamp":[NSNumber numberWithDouble:a],@"isconfig":[NSNumber numberWithInteger:0]} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
//        
//        if (error) {
//            NSLog(@"error = %@",error);
//            [hud hideAnimated:YES];
//            [self makeToast:@"reset error" duration:2.0f position:CSToastPositionCenter];
//        }else{
//            [hud hideAnimated:YES];
//            PTBeginConnectViewController *vc = [[PTBeginConnectViewController alloc]init];
//            [self.yn_viewController.navigationController pushViewController:vc animated:YES];
//            
//            NSLog(@"reset success");
//        }
//    }];
//
//}

- (UILabel *)bodyLabel{
    if (!_bodyLabel) {
        _bodyLabel = [[UILabel alloc]init];
        _bodyLabel.textAlignment = NSTextAlignmentCenter;
        _bodyLabel.text = @"Pentagon is now connected to Wi-Fi";
        _bodyLabel.textColor = k_Color_Title;
        _bodyLabel.font = [UIFont systemFontOfSize:SP(15)];
    }
    return _bodyLabel;
}


- (UILabel *)netLabel{
    if (!_netLabel) {
        _netLabel = [[UILabel alloc]init];
        _netLabel.font = [UIFont systemFontOfSize:SP(12)];
        _netLabel.textColor = k_Color_Title;
        _netLabel.text = @"Network";
    }
    return _netLabel;
}

- (MFTextField *)wifiNameTextField{
    if (!_wifiNameTextField) {
        _wifiNameTextField = [[MFTextField alloc]init];
        _wifiNameTextField.font = [UIFont systemFontOfSize:SP(12)];
        _wifiNameTextField.textColor = k_Color_Title;
        _wifiNameTextField.placeholder = @"input your network";
        _wifiNameTextField.placeholderTextColor = k_Color_Title;
        _wifiNameTextField.textAlignment = NSTextAlignmentLeft;
        _wifiNameTextField.delegate = self;
//        _wifiNameTextField.text = @"vinci-pub";
        
        _wifiNameTextField.hasUnderline = YES;
        _wifiNameTextField.underlineColor = UIColorFromRGB(0x1F0D45);
        
        _wifiNameTextField.leftTextOffset = __SCREEN_WIDTH/2 - SP(15);
        _wifiNameTextField.textRightOffset = -SP(30);
        
        [_wifiNameTextField addSubview:self.netLabel];
        
    }
    return _wifiNameTextField;
}

- (UILabel *)passwordLabel{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc]init];
        _passwordLabel.font = [UIFont systemFontOfSize:SP(12)];
        _passwordLabel.textColor = k_Color_Title;
        _passwordLabel.text = @"Music Service";
    }
    return _passwordLabel;
}

- (MFTextField *)wifiPasswordTextField{
    if (!_wifiPasswordTextField) {
        _wifiPasswordTextField = [[MFTextField alloc]init];
        _wifiPasswordTextField.font = [UIFont systemFontOfSize:SP(12)];
        _wifiPasswordTextField.textColor = k_Color_Title;
        _wifiPasswordTextField.textAlignment = NSTextAlignmentLeft;
        _wifiPasswordTextField.placeholderTextColor = k_Color_Title;
        _wifiPasswordTextField.delegate = self;
        
        _wifiPasswordTextField.hasUnderline = YES;
        _wifiPasswordTextField.underlineColor = UIColorFromRGB(0x1F0D45);
        
        _wifiPasswordTextField.leftTextOffset = __SCREEN_WIDTH/2 - SP(20);
        _wifiPasswordTextField.textRightOffset = SP(-30);
        [_wifiPasswordTextField addSubview:self.passwordLabel];
    }
    return _wifiPasswordTextField;
}


- (PTButton *)musicButton{
    if (!_musicButton) {
        _musicButton = [PTButton buttonWithType:UIButtonTypeCustom];
        
        [_musicButton setTitle:@"Music Service Setup" forState:UIControlStateNormal];
        [_musicButton setTitle:@"Music Service Setup" forState:UIControlStateSelected];
        [_musicButton setTitle:@"Music Service Setup" forState:UIControlStateHighlighted];
        
        _musicButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_musicButton addTarget:self action:@selector(musicServiceAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _musicButton.layer.cornerRadius = 5;
        _musicButton.layer.masksToBounds = YES;
    }
    return _musicButton;
}

- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = [NSString stringWithFormat:@"Your Pentagon MAC Address:%@",[PTWiFiHandler currentMACAddress]];
        _bottomLabel.font = [UIFont systemFontOfSize:SP(12)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = K_Color_04;
        _bottomLabel.numberOfLines = 0;
    }
    return _bottomLabel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.wifiNameTextField resignFirstResponder];
    [self.wifiPasswordTextField resignFirstResponder];
}

@end
