//
//  PTAlertView.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/7/11.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTAlertView.h"

@interface PTAlertView ()

@property (strong, nonatomic) UIView *noticeView;

@property (strong, nonatomic) UILabel *contentLabel;

//@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *velView;

@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIButton *tryButton;

@end

@implementation PTAlertView

+ (instancetype)alertView{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0,0, __SCREEN_WIDTH, __SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:0.3];
        
        [self addSubview:self.noticeView];
        [self setupConstraints];
        
    }
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)quit
{
    [self removeFromSuperview];
}

- (void)nextAction{
    if (self.completeBlock) {
        self.completeBlock();
    }
    [self removeFromSuperview];
}

- (void)setupConstraints{
    
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SP(52.5));
        make.right.equalTo(self.mas_right).offset(-SP(52.5));
        make.top.equalTo(self.mas_top).offset(SP(251));
        make.height.mas_equalTo(SP(165));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeView.mas_left).offset(SP(21.5));
        make.right.equalTo(self.noticeView.mas_right).offset(-SP(21.5));
        make.centerX.equalTo(self.noticeView.mas_centerX);
        make.centerY.equalTo(self.noticeView.mas_centerY).offset(-SP(21));
//        make.width.mas_lessThanOrEqualTo(__SCREEN_WIDTH - 2*SP(86/2) - SP(90));
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.noticeView.mas_bottom);
        make.height.mas_equalTo(SP(43));
        make.left.equalTo(self.noticeView.mas_left);
        make.right.equalTo(self.noticeView.mas_centerX);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.noticeView.mas_bottom);
        make.height.mas_equalTo(SP(43));
        make.left.equalTo(self.noticeView.mas_centerX);
        make.right.equalTo(self.noticeView.mas_right);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(self.noticeView.mas_left);
        make.right.equalTo(self.noticeView.mas_right);
        make.bottom.equalTo(self.cancelButton.mas_top);
    }];
    
    [self.tryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeView.mas_left).offset(SP(69.5));
        make.right.equalTo(self.noticeView.mas_right).offset(-SP(69.5));
        make.height.mas_equalTo(SP(34));
        make.bottom.equalTo(self.noticeView.mas_bottom).offset(-SP(16));
    }];
}

- (void)setAlertType:(PTAlertViewType)alertType{
    _alertType = alertType;
    switch (alertType) {
        case PTTipAlertView:
        {
            self.cancelButton.hidden = YES;
            self.bottomView.hidden = YES;
            self.nextButton.hidden = YES;
            self.tryButton.hidden = NO;
            self.message = @"If you don't find 'Pentagon-XXX' network,restart your Pentagon";
        }
            break;
        case PTNoticeAlertView:{
            self.cancelButton.hidden = NO;
            self.bottomView.hidden = NO;
            self.nextButton.hidden = NO;
            self.tryButton.hidden = YES;
        }
        default:
            break;
    }
}

- (void)setMessage:(NSString *)message{
    _message = message;
    self.contentLabel.text = _message;
}

- (void)setCancelTitle:(NSString *)cancelTitle{
    _cancelTitle = cancelTitle;
    [self.cancelButton setTitle:_cancelTitle forState:UIControlStateNormal];
}

- (void)setNextTitle:(NSString *)nextTitle{
    _nextTitle = nextTitle;
    [self.nextButton setTitle:_nextTitle forState:UIControlStateNormal];
}

- (UIView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[UIView alloc]init];
        _noticeView.layer.cornerRadius = 10;
        _noticeView.layer.masksToBounds = YES;
        _noticeView.backgroundColor = UIColorFromRGB(0x222222);
        [_noticeView addSubview:self.contentLabel];
        [_noticeView addSubview:self.bottomView];
        [_noticeView addSubview:self.cancelButton];
        [_noticeView addSubview:self.nextButton];
        [_noticeView addSubview:self.tryButton];
    }
    return _noticeView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = K_Font_04;
        _contentLabel.textColor = k_Color_Title;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = UIColorFromRGB(0x2D2D2D);
    }
    return _bottomView;
}

- (UIButton *)tryButton {
    if (!_tryButton) {
        _tryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tryButton.titleLabel.font = [UIFont systemFontOfSize:SP(18)];
        [_tryButton setTitle:@"Try again" forState:UIControlStateNormal];
        [_tryButton setTitleColor:k_Color_Title forState:UIControlStateNormal];
        _tryButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _tryButton.backgroundColor = k_Color_Normal;
        _tryButton.layer.cornerRadius = 5;
        _tryButton.layer.masksToBounds = YES;
        
        [_tryButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tryButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:k_Color_Disable forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:SP(17)];
        [_cancelButton setTitle:@"NO" forState:UIControlStateNormal];
    }
    return _cancelButton;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitleColor:k_Color_Normal forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:SP(17)];
        [_nextButton setTitle:@"YES" forState:UIControlStateNormal];
    }
    return _nextButton;
}


@end
