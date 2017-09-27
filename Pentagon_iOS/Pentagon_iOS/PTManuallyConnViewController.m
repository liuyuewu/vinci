//
//  PTManuallyConnViewController.m
//  Pentagon_iOS
//
//  Created by Vinci on 2017/9/20.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTManuallyConnViewController.h"
#import "PTScanBLEViewController.h"
#import "PTButton.h"

@interface PTManuallyConnViewController ()

@property (strong, nonatomic) UIImageView *titleImageView;
@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UIImageView *bodyImageView;

@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) PTButton *connectButton;


@end

@implementation PTManuallyConnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self.view addSubview:self.bodyImageView];
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.connectButton];
    
    // Do any additional setup after loading the view.
}


- (void)setupNavigation{
    self.titleLabel.text = @"Step 1";
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    
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
    
}

- (void)nextAction:(UIButton *)button{
    
    PTScanBLEViewController *vc = [[PTScanBLEViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
        _noticeLabel.attributedText = [_noticeLabel setText:@"Power on Vinci" withParagraphHeight:1 withKernAttributeHeight:0.5];
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
        _messageLabel.attributedText = [_messageLabel setText:@"Power on Vinci. Vinci will turn on Bluetooth automatically." withParagraphHeight:SP(8) withKernAttributeHeight:0.5];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.textColor = k_Color_SubTitle;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (PTButton *)connectButton{
    if (!_connectButton) {
        _connectButton = [PTButton buttonWithType:UIButtonTypeCustom];
        [_connectButton setTitle:@"Next" forState:UIControlStateNormal];
        _connectButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _connectButton.enabled = YES;
        [_connectButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}



@end
