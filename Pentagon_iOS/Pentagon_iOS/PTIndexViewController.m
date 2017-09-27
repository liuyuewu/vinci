//
//  PTIndexViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTIndexViewController.h"

//controller
#import "PTWifiViewController.h"
#import "PTMusicServiceViewController.h"
#import "PTConnectWiFiViewController.h"

//view
#import "PTButton.h"
#import "PTBodyCommonView.h"
#import "PTBodyConnectView.h"

@interface PTIndexViewController ()

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIButton *connectButton;
@property (strong, nonatomic) PTBodyCommonView *commonView;
@property (strong, nonatomic) PTBodyConnectView *connectView;


@end

@implementation PTIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置navigation样式
    [self setupNavigation];
    self.view.backgroundColor = K_Color_10;
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.commonView];
    [self.view addSubview:self.connectView];
    
    __weak typeof(self) weakSelf = self;
    self.commonView.wifiBlock = ^{
        NSLog(@"wifi click");
        PTWifiViewController *vc = [[PTWifiViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.commonView.musicBlock = ^{
        NSLog(@"music click");
        PTMusicServiceViewController *vc = [[PTMusicServiceViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.connectView.musicServiceBlock = ^{
        PTMusicServiceViewController *vc = [[PTMusicServiceViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.connectView.chooseNetworkBlock = ^{
        PTConnectWiFiViewController *vc = [[PTConnectWiFiViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.connectView.hidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    [self.commonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.topView.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.connectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.topView.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)setupNavigation{
    self.titleLabel.text = @"Pentagon";
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"Pair new Device" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"Pair new Device" forState:UIControlStateSelected];
}

#pragma mark - Private Click

-(void)rightClick{
    [self.view makeToast:@"Pair new Device" duration:1.0f position:CSToastPositionCenter];
}

- (void)connectAction:(UIButton *)button{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:1.0];
    pulse.toValue= [NSNumber numberWithFloat:1.2];
    [self.connectButton.layer addAnimation:pulse forKey:nil];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.connectButton.selected = !button.selected;
        
        if (self.connectButton.selected) {
            [self.commonView updateViewWithConnectStatus:PTConnectSuccessStatus];
        }else{
            [self.commonView updateViewWithConnectStatus:PTDisConnectStatus];
        }
    });
}

#pragma mark - Private method


#pragma mark - Property

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, __NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH, SP(131))];
        _topView.backgroundColor = k_Color_Black;
        [_topView addSubview:self.connectButton];
        
    }
    return _topView;
}

- (UIButton *)connectButton{
    if (!_connectButton) {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_connectButton setFrame:CGRectMake((__SCREEN_WIDTH - SP(84))/2, SP(25), SP(84), SP(84))];
        _connectButton.layer.cornerRadius = SP(42);
        _connectButton.layer.masksToBounds = YES;
        _connectButton.layer.borderColor = [UIColor grayColor].CGColor;
        _connectButton.layer.borderWidth = 3;
        _connectButton.titleLabel.numberOfLines = 0;
        [_connectButton setTitle:@"Ready to\n connect" forState:UIControlStateNormal];
        [_connectButton setTitle:@"Wifi \n Connected" forState:UIControlStateSelected];
        _connectButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _connectButton.titleLabel.font = [UIFont systemFontOfSize:SP(11)];
        [_connectButton setTitleColor:K_Color_09 forState:UIControlStateNormal];
        [_connectButton setTitleColor:K_Color_09 forState:UIControlStateSelected];
        [_connectButton yn_setBackgroundColor:k_Color_Black forState:UIControlStateNormal];
        [_connectButton yn_setBackgroundColor:K_Color_01 forState:UIControlStateSelected];
        [_connectButton addTarget:self action:@selector(connectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (PTBodyCommonView *)commonView{
    if (!_commonView) {
        _commonView = [[PTBodyCommonView alloc]init];
    }
    return _commonView;
}

- (PTBodyConnectView *)connectView{
    if (!_connectView) {
        _connectView = [[PTBodyConnectView alloc]init];
    }
    return _connectView;
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
