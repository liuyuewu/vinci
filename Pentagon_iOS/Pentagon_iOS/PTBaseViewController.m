//
//  PTBaseViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBaseViewController.h"
#import <AFNetworkReachabilityManager.h>

@interface PTBaseViewController ()

@property (strong, nonatomic) UIViewController *currentVC;

@end

@implementation PTBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isModal = NO;
        self.isShowBottomSeperatorLine = NO;
        self.leftButton.hidden = NO;
        self.rightButton.hidden = YES;
        self.leftButtonItems = @[self.leftButton];
        self.rightButtonItems = @[];
        
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString* cName = [NSString stringWithFormat:@"%@",[self class]];
    NSLog(@"cName = %@",cName);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_Color_Background;
    [self.view addSubview:self.customNav];
    [self setConstraints];
    [self monitorNetwork];
    // Do any additional setup after loading the view.
}

- (void)removeController{
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    NSArray *narray = @[navigationArray[navigationArray.count - 1]];
    
    self.navigationController.viewControllers = narray;
    
}

- (void)removeAllKey{
    
    return;
    
//    [NSUserDefaults yn_setObject:@"false" forKey:PTConnectWifiKey];
//    [NSUserDefaults yn_setObject:@"false" forKey:PTMusicService];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTSpotifyAccessToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTAlexaAccessToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTSpotifyRefreshToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTAlexaRefreshToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTSpotifyTokenType];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTAlexaTokenType];
//    [NSUserDefaults removeObjcFromDefaultWithKey:@"selectMusicService"];

}
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)monitorNetwork{
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                debugLog(@"当前网络连接失败，请查看设置");
                [self.view makeToast:@"当前网络连接失败"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                debugLog(@"正在通过手机网络进行连接");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                debugLog(@"正在用wifi进行连接");
                break;
            case AFNetworkReachabilityStatusUnknown:
                break;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
}

- (void)setConstraints{
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.customNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.right.equalTo(self.view.mas_right).with.offset(padding.right);
        make.height.equalTo(@64);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNav.mas_top).with.offset(20);
        make.bottom.equalTo(self.customNav.mas_bottom).with.offset(padding.bottom);
        make.centerX.equalTo(self.customNav.mas_centerX);
        make.width.lessThanOrEqualTo(@200);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNav.mas_top).offset(20);
        make.left.equalTo(self.customNav.mas_left).offset(SP(8));
        make.bottom.equalTo(self.customNav.mas_bottom);
        make.width.mas_greaterThanOrEqualTo(@30);
        make.height.mas_greaterThanOrEqualTo(@30);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNav.mas_top).offset(20);
        make.right.equalTo(self.customNav.mas_right).offset(-SP(8));
        make.bottom.equalTo(self.customNav.mas_bottom);
        make.width.mas_greaterThanOrEqualTo(@30);
        make.height.mas_greaterThanOrEqualTo(@30);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - click method

- (void)leftClick{
    if (self.isModal) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClick{
    
}

#pragma mark - Property

- (void)setLeftButtonItems:(NSArray *)leftButtonItems{
    _leftButtonItems = leftButtonItems;
    if (_leftButtonItems != 0) {
        [self addLeftButtonItems];
    }
}

- (void)addLeftButtonItems{
    for (int i = 0; i< _leftButtonItems.count; i++) {
        UIButton *button = _leftButtonItems[i];
        [button setFrame:CGRectMake(10+46*i, 24, 36, 36)];
        [self.customNav addSubview:button];
    }
    
}

- (UIView *)customNav{
    if (!_customNav) {
        _customNav = [[UIView alloc]init];
        _customNav.backgroundColor = K_Color_Clear;
        [_customNav addSubview:self.leftButton];
        [_customNav addSubview:self.titleLabel];
        [_customNav addSubview:self.rightButton];
    }
    return _customNav;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = k_Color_Title;
    }
    return _titleLabel;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage imageNamed:@"nav_Return"] forState:UIControlStateNormal];
        [_leftButton setTitleColor:K_Color_09 forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:k_Color_Title forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
