//
//  PTSetupReadyViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTSetupReadyViewController.h"
#import "PTConnectNoticeViewController.h"
#import "PTButton.h"
#import "PTWiFiHandler.h"

@interface PTSetupReadyViewController ()

@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) PTButton *connectButton;

@end

@implementation PTSetupReadyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.connectButton];
    
    // Do any additional setup after loading the view.
}

- (void)setupNavigation{
    self.titleLabel.text = @"Pentagon Setup";
    self.leftButton.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self removeController];
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(30));
        make.right.equalTo(self.view.mas_right).offset(-SP(30));
        make.top.equalTo(self.view.mas_top).offset(__NAVIGATION_BAR_HEIGHT + SP(40));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeLabel.mas_left);
        make.right.equalTo(self.noticeLabel.mas_right);
        make.top.equalTo(self.noticeLabel.mas_bottom).offset(SP(75));
    }];
    
    [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-SP(150));
        make.left.equalTo(self.view.mas_left).offset(SP(30));
        make.right.equalTo(self.view.mas_right).offset(-SP(30));
        make.height.mas_equalTo(41);
    }];
    
}

- (void)nextAction:(UIButton *)button{
    if ([[PTWiFiHandler currentSSID] hasPrefix:PTJudgeWiFiKey]) {
        Class class = NSClassFromString(@"PTContinueNoticeViewController");
        [self.navigationController pushViewController:[[class alloc]init] animated:YES];
        
    }else{
        if (SYSTEM_VERSION_GREATER_THAN(@"10.0")) {
            NSURL*url=[NSURL URLWithString:@"App-Prefs:root=WIFI"];
            [[UIApplication sharedApplication] openURL:url];
        }else{
            NSURL*url=[NSURL URLWithString:@"prefs:root=WIFI"];
            [[UIApplication sharedApplication] openURL:url];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            PTConnectNoticeViewController *vc = [[PTConnectNoticeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
}

#pragma mark - Property

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.text = @"Wait for Pentagon Wi-Fi setup ready";
        _noticeLabel.font = [UIFont systemFontOfSize:SP(18)];
        _noticeLabel.textColor = K_Color_11;
    }
    return _noticeLabel;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:SP(12)];
        _messageLabel.text = @"Make sure your Pentagon is power on. In about a minute, Pentagon will tell you that it is ready for Wi-Fi setup, Then continue";
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (PTButton *)connectButton{
    if (!_connectButton) {
        _connectButton = [PTButton buttonWithType:UIButtonTypeCustom];
        [_connectButton setTitle:@"Continue" forState:UIControlStateNormal];
        [_connectButton setTitle:@"Continue" forState:UIControlStateSelected];
        _connectButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _connectButton.enabled = YES;
        [_connectButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
