//
//  PTConnectNoticeViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTConnectNoticeViewController.h"
#import "PTConnectStatusViewController.h"
#import "PTButton.h"
#import "PTWiFiHandler.h"
#import "PTAlertView.h"

@interface PTConnectNoticeViewController ()

@property (strong, nonatomic) UIImageView *titleImageView;
@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UIImageView *bodyImageView;

@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) PTButton *connectButton;
@property (strong, nonatomic) UILabel *tipLabel;

@end

@implementation PTConnectNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self.view addSubview:self.bodyImageView];
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.connectButton];
    [self.view addSubview:self.tipLabel];

    // Do any additional setup after loading the view.
}

- (void)pushVC:(NSNotification *)noti{
    Class class = NSClassFromString(@"PTChooseWiFIViewController");
    [self.navigationController pushViewController:[[class alloc]init] animated:YES];
}


- (void)setupNavigation{
    [self.customNav addSubview:self.titleImageView];
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNav.mas_bottom).offset(SP(24));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.bodyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(63));
        make.right.equalTo(self.view.mas_right).offset(-SP(63));
        make.top.equalTo(self.noticeLabel.mas_bottom).offset(SP(33));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeLabel.mas_left).offset(SP(50));
        make.right.equalTo(self.noticeLabel.mas_right).offset(-SP(50));
        make.top.equalTo(self.bodyImageView.mas_bottom).offset(SP(49));
    }];
    
    [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-SP(72));
        make.left.equalTo(self.view.mas_left).offset(SP(50));
        make.right.equalTo(self.view.mas_right).offset(-SP(50));
        make.height.mas_equalTo(45);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(20));
        make.bottom.equalTo(self.view.mas_bottom).offset(-37);
        make.right.equalTo(self.view.mas_right).offset(-SP(20));
    }];
    
}

- (void)nextAction:(UIButton *)button{
    if ([[PTWiFiHandler currentSSID] hasPrefix:PTJudgeWiFiKey]) {
        PTConnectStatusViewController *vc = [[PTConnectStatusViewController alloc]init];
        vc.wifiName = self.wifiName;
        vc.wifiPassword = self.wifiPassword;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (SYSTEM_VERSION_GREATER_THAN(@"10.0")) {
            NSURL*url=[NSURL URLWithString:@"App-Prefs:root=WIFI"];
            [[UIApplication sharedApplication] openURL:url];
        }else{
            NSURL*url=[NSURL URLWithString:@"prefs:root=WIFI"];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)tapTipAction{
    PTAlertView *alert = [PTAlertView alertView];
    alert.alertType = PTTipAlertView;
    alert.completeBlock = ^{
    };
    [alert show];
}

#pragma mark - Property

- (UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleImageView.image = [UIImage imageNamed:@"icon_pentagon_2"];
    }
    return _titleImageView;
}

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.attributedText = [_noticeLabel setText:@"Manually Connect to Pentagon" withParagraphHeight:1 withKernAttributeHeight:0.5];
        _noticeLabel.font = [UIFont systemFontOfSize:SP(15)];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.textColor = k_Color_Title;
    }
    return _noticeLabel;
}

- (UIImageView *)bodyImageView{
    if (!_bodyImageView) {
        _bodyImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_iphone"]];
        _bodyImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bodyImageView;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:SP(12)];
        _messageLabel.attributedText = [_messageLabel setText:@"Go to your Wi-Fi settings on this iPhone and select the network of the format Pentagon-XXX. it may take up to a minute to display. Wait until Pentagon says you are connected. then return to this screen." withParagraphHeight:SP(8) withKernAttributeHeight:0.5];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.textColor = k_Color_SubTitle;
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

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.font = [UIFont systemFontOfSize:SP(12)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = K_Color_04;
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = @"Don't find 'Pentagon-XXX' network";
        _tipLabel.userInteractionEnabled = YES;
        
        @WeakObj(self);
        [_tipLabel yn_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            @StrongObj(self);
            [self tapTipAction];
        }];
    }
    return _tipLabel;
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
