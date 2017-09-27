//
//  PTConnectProgressView.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTConnectProgressView.h"

@interface PTConnectProgressView ()

@property (strong, nonatomic) CADisplayLink *displayLink;

@property (strong, nonatomic) UILabel *noticeLabel;

@property (strong, nonatomic) UIBezierPath *path1;
@property (strong, nonatomic) CAShapeLayer *bottomLayer;

@property (strong, nonatomic) UIBezierPath *path2;
@property (strong, nonatomic) CAShapeLayer *progressLayer;

@property (assign, nonatomic) CGFloat plusWidth;

@property (strong, nonatomic) UILabel *tipLabel;

@end

@implementation PTConnectProgressView


- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = K_Color_Clear;
        [self addSubview:self.noticeLabel];
        [self addSubview: self.tipLabel];
        _plusWidth = 0.01;
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SP(24));
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SP(333));
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}

- (void)drawRect:(CGRect)rect{
    
    CGPoint point1 = CGPointMake(SP(285/2), SP(520/2));
    CGPoint point2 = CGPointMake(SP(213/2), SP(370/2));
    CGPoint point3 = CGPointMake(SP(304/2), SP(260/2));
    CGPoint point4 = CGPointMake(SP(442/2), SP(260/2));
    CGPoint point5 = CGPointMake(SP(535/2), SP(370/2));
    CGPoint point6 = CGPointMake(SP(468/2), SP(520/2));
    
    self.path1 = [UIBezierPath bezierPath];
    self.path1.lineCapStyle = kCGLineCapRound;
    self.path1.lineJoinStyle = kCGLineJoinRound;
    [self.path1 moveToPoint:point1];
    [self.path1 addLineToPoint:point2];
    [self.path1 addLineToPoint:point3];
    [self.path1 addLineToPoint:point4];
    [self.path1 addLineToPoint:point5];
    [self.path1 addLineToPoint:point6];
    [self.path1 stroke];
    
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.fillColor = K_Color_Clear.CGColor;
    self.bottomLayer.strokeColor = k_Color_Disable.CGColor;
    self.bottomLayer.path = self.path1.CGPath;
    self.bottomLayer.strokeEnd = 1.0f;
    self.bottomLayer.lineWidth = 5;
    [self.layer addSublayer:self.bottomLayer];
    
    self.path2 = [UIBezierPath bezierPath];
    self.path2.lineCapStyle = kCGLineCapRound;
    self.path2.lineJoinStyle = kCGLineJoinRound;
    
    [self.path2 moveToPoint:point1];
    [self.path2 addLineToPoint:point2];
    [self.path2 addLineToPoint:point3];
    [self.path2 addLineToPoint:point4];
    [self.path2 addLineToPoint:point5];
    [self.path2 addLineToPoint:point6];
    [self.path2 stroke];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor = K_Color_Clear.CGColor;
    self.progressLayer.strokeColor = k_Color_Normal.CGColor;
    self.progressLayer.path = self.path2.CGPath;
    self.progressLayer.strokeEnd = 0;
    self.progressLayer.lineWidth = 5;
    [self.layer addSublayer:self.progressLayer];
}

- (void)startConnect{
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)resume{
    self.progressLayer.strokeEnd = 1.0;
}

- (void)refreshUI{
    self.progressLayer.strokeEnd += _plusWidth;
    
    if (self.progressLayer.strokeEnd > 0.9) {
        _plusWidth = 0;
    }
}

#pragma mark - Property

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.font = [UIFont systemFontOfSize:SP(15)];
        _noticeLabel.textColor = k_Color_Title;
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.text = @"Prepare your Pentagon";
    }
    return _noticeLabel;
}


- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:SP(12)];
        _tipLabel.textColor = k_Color_Title;
        _tipLabel.text = @"This may take a few minutes.";
    }
    return _tipLabel;
}
- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshUI)];
    }
    return _displayLink;
}

@end
