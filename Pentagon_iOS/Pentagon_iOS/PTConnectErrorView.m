//
//  PTConnectErrorView.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/28.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTConnectErrorView.h"

@interface PTConnectErrorView ()

@property (strong, nonatomic) UILabel *errorMessageLabel;
@property (strong, nonatomic) UIButton *closeButton;

@end

@implementation PTConnectErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.errorMessageLabel];
        [self addSubview:self.closeButton];
        [self setup];
    }
    return self;
}

- (void)setup{
    [self.errorMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
    }];

}

- (void)closeClick{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

#pragma mark - 

- (UILabel *)errorMessageLabel{
    if (!_errorMessageLabel) {
        _errorMessageLabel = [[UILabel alloc]init];
        _errorMessageLabel.text = @"Unable to complete setup,Please try again";
        _errorMessageLabel.textAlignment = NSTextAlignmentCenter;
        _errorMessageLabel.textColor = k_Color_Title;
        _errorMessageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _errorMessageLabel;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"icon_closed"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
