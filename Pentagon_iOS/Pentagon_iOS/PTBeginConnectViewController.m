//
//  PTBeginConnectViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBeginConnectViewController.h"
#import "PTSetupReadyViewController.h"
#import "PTButton.h"
#import "PTMusicServiceViewController.h"
#import "PTManuallyConnViewController.h"
#import "PTWiFiHandler.h"



@interface PTBeginConnectViewController ()

@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) PTButton *connectButton;


@end



@implementation PTBeginConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.connectButton];
//    [self.view addSubview:self.button];
    
    // Do any additional setup after loading the view
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self removeController];
}

- (void)setupNavigation{
    self.titleLabel.text = @"Vinci";
    self.leftButton.hidden = YES;
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(43));
        make.right.equalTo(self.view.mas_right).offset(-SP(43));
        make.top.equalTo(self.view.mas_top).offset(__NAVIGATION_BAR_HEIGHT + SP(171));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(40));
        make.right.equalTo(self.view.mas_right).offset(-SP(40));
        make.top.equalTo(self.noticeLabel.mas_bottom).offset(SP(16));
    }];
    
    [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-SP(72));
        make.left.equalTo(self.view.mas_left).offset(SP(50));
        make.right.equalTo(self.view.mas_right).offset(-SP(50));
        make.height.mas_equalTo(44);
    }];
    


}

- (void)nextAction:(UIButton *)button{
    PTManuallyConnViewController *vc = [[PTManuallyConnViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    PTMusicServiceViewController *vc = [[PTMusicServiceViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - Property

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.attributedText = [_noticeLabel setText:@"Begin Vinci Setup" withParagraphHeight:1 withKernAttributeHeight:0.5];
        _noticeLabel.font = [UIFont systemFontOfSize:SP(15)];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.textColor = k_Color_Title;
    }
    return _noticeLabel;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:SP(12)];
        _messageLabel.attributedText = [_messageLabel setText:@"Let’s get your Vinci connected to WiFi so you can start using it." withParagraphHeight:SP(8) withKernAttributeHeight:0.5];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.textColor = k_Color_SubTitle;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (PTButton *)connectButton{
    if (!_connectButton) {
        _connectButton = [PTButton buttonWithType:UIButtonTypeCustom];
        [_connectButton setTitle:@"Connect to WiFi" forState:UIControlStateNormal];
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
