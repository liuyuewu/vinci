//
//  PTBodyCommonView.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBodyCommonView.h"
#import "PTButton.h"

@interface PTBodyCommonView ()

@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UILabel *subBodyLabel;
@property (strong, nonatomic) PTButton *wifiButton;
@property (strong, nonatomic) PTButton *musicButton;
@property (strong, nonatomic) UILabel *bottomLabel;

@end

@implementation PTBodyCommonView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = K_Color_10;
        [self addSubview:self.bodyLabel];
        [self addSubview:self.subBodyLabel];
        [self addSubview:self.wifiButton];
        [self addSubview:self.musicButton];
        [self addSubview:self.bottomLabel];
    }
    return self;
}

- (void)updateConstraints{
    
    [super updateConstraints];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(30));
        make.right.equalTo(self.mas_right).offset(-SP(30));
        make.top.equalTo(self.mas_top).offset(SP(45));
    }];
    
    [self.subBodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bodyLabel.mas_left);
        make.right.equalTo(self.bodyLabel.mas_right);
        make.top.equalTo(self.bodyLabel.mas_bottom).offset(SP(25));
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(20));
        make.bottom.equalTo(self.mas_bottom).offset(-14);
        make.right.equalTo(self.mas_right).offset(-SP(20));
    }];
    
    [self.musicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(30));
        make.right.equalTo(self.mas_right).offset(-SP(30));
        make.height.mas_equalTo(41);
        make.bottom.equalTo(self.mas_bottom).offset(-SP(150));
    }];
    
    [self.wifiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(30));
        make.right.equalTo(self.mas_right).offset(-SP(30));
        make.height.mas_equalTo(41);
        make.bottom.equalTo(self.musicButton.mas_top).offset(-SP(21));
    }];
}

- (void)updateViewWithConnectStatus:(PTConnectStatus)status{
    switch (status) {
        case PTConnectSuccessStatus:
        {
            self.bodyLabel.hidden = NO;
            self.subBodyLabel.text = @"Wi-Fi & Music Service";
            [self.musicButton setEnabled:YES];
            [self.wifiButton setEnabled:YES];

        }
            break;
        case PTDisConnectStatus:
        {
            self.bodyLabel.hidden = YES;
            self.subBodyLabel.text = @"Make sure your Pentagon is on. in about a minute,Pentagon will reconnected. Then continue";
            [self.musicButton setEnabled:NO];
            [self.wifiButton setEnabled:NO];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Private click

- (void)wifiSetupAction:(UIButton *)button{
    if (self.wifiBlock) {
        self.wifiBlock();
    }
}

- (void)musicServiceAction:(UIButton *)button{
    if (self.musicBlock) {
        self.musicBlock();
    }
}

#pragma mark - Property

- (UILabel *)bodyLabel{
    if (!_bodyLabel) {
        _bodyLabel = [[UILabel alloc]init];
        _bodyLabel.textAlignment = NSTextAlignmentLeft;
        _bodyLabel.text = @"Please Continue to setup";
        _bodyLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _bodyLabel.font = [UIFont systemFontOfSize:SP(18)];
        _bodyLabel.hidden = YES;
    }
    return _bodyLabel;
}

- (UILabel *)subBodyLabel{
    if (!_subBodyLabel) {
        _subBodyLabel = [[UILabel alloc]init];
        _subBodyLabel.font = [UIFont systemFontOfSize:SP(12)];
        _subBodyLabel.text = @"Make sure your Pentagon is on. in about a minute,Pentagon will reconnected. Then continue";
        _subBodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _subBodyLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _subBodyLabel.numberOfLines = 0;
    }
    return _subBodyLabel;
}

- (PTButton *)wifiButton{
    if (!_wifiButton) {
        _wifiButton = [PTButton buttonWithType:UIButtonTypeCustom];
        [_wifiButton setTitle:@"Wi-Fi setup" forState:UIControlStateNormal];
        [_wifiButton setTitle:@"Wi-Fi setup" forState:UIControlStateSelected];
        _wifiButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _wifiButton.enabled = NO;
        [_wifiButton addTarget:self action:@selector(wifiSetupAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wifiButton;
}

- (PTButton *)musicButton{
    if (!_musicButton) {
        _musicButton = [PTButton buttonWithType:UIButtonTypeCustom];
        [_musicButton setTitle:@"Music Service" forState:UIControlStateNormal];
        [_musicButton setTitle:@"Music Service" forState:UIControlStateSelected];
        _musicButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _musicButton.enabled = NO;
        [_musicButton addTarget:self action:@selector(musicServiceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _musicButton;
}

- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = [NSString stringWithFormat:@"Your Pentagon MAC Address:%@",@"38:38:38:38"];
        _bottomLabel.font = [UIFont systemFontOfSize:SP(14)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _bottomLabel.numberOfLines = 0;
    }
    return _bottomLabel;
}

@end
