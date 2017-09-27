//
//  PTLoadingViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/7/7.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTLoadingViewController.h"
#import "PTBeginConnectViewController.h"
#import <YYImage.h>
#import "PTConnectViewController.h"
#import <JQFMDB.h>
#import "PTWifiModel.h"


@interface PTLoadingViewController ()

@property (strong, nonatomic) UILabel *logoLabel;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) CALayer *forengroundLayer;
@property (strong, nonatomic) CALayer *backgroundLayer;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *loadingImageView;


@end

@implementation PTLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNav.hidden = YES;
    self.view.backgroundColor = K_Color_09;

    [self.view.layer addSublayer:self.forengroundLayer];
    [self.view.layer addSublayer:self.backgroundLayer];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.logoLabel];
    [self.view addSubview:self.loadingImageView];
    //[self.view addSubview:self.indicatorView];
    
//    [self signin];
    
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PTBeginConnectViewController *vc = [[PTBeginConnectViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    });
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}



- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.loadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(SP(212));
    }];
    
    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.loadingImageView.mas_bottom).offset(SP(11));
    }];
    
//    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.logoLabel.mas_centerX);
//        make.top.equalTo(self.logoLabel.mas_bottom).offset(20);
//    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - Property

- (UILabel *)logoLabel{
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc]init];
        _logoLabel.font = [UIFont systemFontOfSize:24];
        _logoLabel.textColor = K_Color_09;
        _logoLabel.text = @"Vinci";
    }
    return _logoLabel;
}

- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]init];
        [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _indicatorView;
}

- (UIImageView *)loadingImageView{
    if (!_loadingImageView) {
        YYImage *image = [YYImage imageNamed:@"demo.gif"];
        _loadingImageView = [[YYAnimatedImageView alloc]initWithImage:image];
    }
    return _loadingImageView;
}

- (CALayer *)forengroundLayer{
    if (!_forengroundLayer) {
        _forengroundLayer = [[CALayer alloc]init];
        _forengroundLayer.frame = CGRectMake(0, 0, __SCREEN_WIDTH, __SCREEN_HEIGHT);
        _forengroundLayer.backgroundColor = k_Color_Foreground.CGColor;
    }
    return _forengroundLayer;
}

- (CALayer *)backgroundLayer{
    if (!_backgroundLayer) {
        _backgroundLayer = [[CALayer alloc]init];
        _backgroundLayer.frame = CGRectMake(0, 0, __SCREEN_WIDTH, __SCREEN_HEIGHT);
        _backgroundLayer.backgroundColor = k_Color_Background.CGColor;
        
    }
    return _backgroundLayer;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.image = [UIImage imageNamed:@"default_bg"];
    }
    return _imageView;
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
