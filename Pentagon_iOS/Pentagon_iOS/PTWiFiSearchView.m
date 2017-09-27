//
//  PTWiFiSearchView.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTWiFiSearchView.h"

@interface PTWiFiSearchView ()

@property (strong, nonatomic) UIView *searchView;
@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) UILabel *searchLabel;

@end

@implementation PTWiFiSearchView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = K_Color_10;
        [self addSubview:self.searchView];
        [self addSubview:self.bodyLabel];
        [self addSubview:self.indicatorView];
        [self addSubview:self.searchLabel];
        [self.indicatorView startAnimating];
        
        dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{

            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(timer, ^{
                [self addDevice];
            });
            dispatch_resume(timer);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                [self.indicatorView stopAnimating];
                dispatch_source_cancel(timer);
                self.searchLabel.hidden = YES;
            });

        });
        

    }
    return self;
}

- (void)addDevice{
    CGFloat x = 110+160*((float)(arc4random()%99)/100);
    CGFloat y = 120+160*((float)(arc4random()%99)/100);
    
    NSLog(@"x = %f y = %f",x,y);

    MFButton *button = [MFButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(x, y, 40, 30)];
    [button setTitle:@"88:2f:23:3d:11:dd" forState:UIControlStateNormal];
    [button setTitleColor:K_Color_01 forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:5];
    [button setImage:[UIImage imageNamed:@"earphone"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(connectClick:) forControlEvents:UIControlEventTouchUpInside];
    
    button.type = buttonTypePicTop;
    button.picTileRange = 0;
    [self.searchView addSubview:button];
    
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:1.0];
    pulse.toValue= [NSNumber numberWithFloat:1.2];
    [button.layer addAnimation:pulse forKey:nil];
}

- (void)connectClick:(MFButton *)button{
    if (self.connectBlock) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewForLastBaselineLayout animated:YES];
        hud.label.text = @"连接设备中";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.connectBlock();
        });
    }
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(SP(322));
    }];
    
    [self.bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom).offset(SP(75));
        make.left.equalTo(self.mas_left).offset(SP(30));
        make.right.equalTo(self.mas_right).offset(-SP(30));
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-45);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchLabel.mas_centerY);
        make.right.equalTo(self.searchLabel.mas_left).offset(-3);
    }];
    
}

- (void)drawRect:(CGRect)rect{
    
    NSArray *colorArray = @[UIColorFromRGB(0xdddddd),UIColorFromRGB(0xcccccc),UIColorFromRGB(0xbbbbbb),UIColorFromRGB(0xaaaaaa)];
    NSArray *radiusArray = @[@"120",@"80",@"55",@"30"];
    
    for (int i = 0; i<radiusArray.count; i++) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(__SCREEN_WIDTH/2, 200) radius:[radiusArray[i] floatValue] startAngle:0 endAngle:2*M_PI clockwise:YES];
        path.lineWidth = 2.0f;
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.strokeColor = ((UIColor *)(colorArray[i])).CGColor;
        layer.fillColor = K_Color_Clear.CGColor;
        [self.searchView.layer addSublayer:layer];
    }
    
}

#pragma mark - Property

- (UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc]init];
    }
    return _searchView;
}

- (UILabel *)bodyLabel{
    if (!_bodyLabel) {
        _bodyLabel = [[UILabel alloc]init];
        _bodyLabel.numberOfLines = 0;
        _bodyLabel.font = [UIFont systemFontOfSize:12];
        _bodyLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _bodyLabel.text = @"Make sure your Pentagon is on. in about a minute,Pentagon will tell you that it is ready. Then continue";
        _bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _bodyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bodyLabel;
}

- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (UILabel *)searchLabel{
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc]init];
        _searchLabel.font = [UIFont systemFontOfSize:18];
        _searchLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _searchLabel.text = @"Searching";
    }
    return _searchLabel;
}

@end
