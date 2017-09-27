//
//  PTConnectWiFiViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTConnectWiFiViewController.h"
#import "PTChooseWiFIViewController.h"
#import "PTWifiModel.h"
#import <JQFMDB.h>
#import "PTConnectErrorView.h"
#import "PTWiFiHandler.h"
#import "PTButton.h"
#import "PTConnectNoticeViewController.h"
#import "PTConnectViewController.h"
#import "PTConnectStatusViewController.h"
#import "BluetoothManager.h"
#import "SppProtocol.pbobjc.h"
#import "PTMusicServiceViewController.h"


@interface PTConnectWiFiViewController () <UITextFieldDelegate>{
    BluetoothManager *manager;
}

@property (strong, nonatomic) UIImageView *titleImageView;

@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UILabel *netLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UIButton *passwordButton;

@property (strong, nonatomic) MFTextField *wifiNameTextField;
@property (strong, nonatomic) MFTextField *wifiPasswordTextField;
@property (strong, nonatomic) PTButton *connectButton;

@property (strong, nonatomic) JQFMDB *db;
@property (strong, nonatomic) PTConnectErrorView *errorView;

@property (strong, nonatomic) UILabel *pushLabel;

@end

@implementation PTConnectWiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.wifiNameTextField];
    [self.view addSubview:self.wifiPasswordTextField];
    [self.view addSubview:self.connectButton];
    [self.view addSubview:self.passwordButton];
    [self.view addSubview:self.pushLabel];
    self.db = [JQFMDB shareDatabase];
    NSString *wifiName = @"360WiFi-Android";
    NSArray *wifiArray = [self.db jq_lookupTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"where ssid = %@",wifiName]];
    for (PTWifiModel *model in wifiArray) {
//        self.wifiNameTextField.text = model.ssid;
        
//        self.wifiPasswordTextField.text = model.password;
        
        

    }
    self.wifiNameTextField.text = @"pentagon";
    
    
    self.wifiPasswordTextField.text = @"12345678";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showWifiStatusView) name:PDBabyBlueToothWIFINofification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];


    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    manager = [BluetoothManager shareInstance];
}

- (void)keyboardChangeFrame:(NSNotification *)note{
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat endY = rect.origin.y;
    NSLog(@"text field height = %f",rect.size.height);
    [UIView animateWithDuration:time animations:^{
        self.connectButton.transform = CGAffineTransformMakeTranslation(0, endY - __SCREEN_HEIGHT);
    }];
}

- (void)setupNavigation{
    [self.customNav addSubview:self.titleImageView];
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNav.mas_bottom).offset(SP(24));
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(30));
        make.top.equalTo(self.view.mas_top).offset(__NAVIGATION_BAR_HEIGHT + SP(22));
    }];
    
    [self.netLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wifiNameTextField.mas_centerY);
        make.left.equalTo(self.wifiNameTextField.mas_left);
    }];
    
    [self.wifiNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(15));
        make.right.equalTo(self.view.mas_right).offset(-SP(15));
        make.top.equalTo(self.noticeLabel.mas_bottom).offset(SP(24));
        make.height.mas_equalTo(SP(36));
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.wifiPasswordTextField.mas_centerY);
        make.left.equalTo(self.wifiPasswordTextField.mas_left);
    }];
    
    [self.wifiPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(15));
        make.right.equalTo(self.view.mas_right).offset(-SP(15));
        make.top.equalTo(self.wifiNameTextField.mas_bottom).offset(6);
        make.height.mas_equalTo(SP(36));
    }];
    
    [self.passwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wifiPasswordTextField.mas_right).offset(-SP(7));
        make.centerY.equalTo(self.wifiPasswordTextField.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(50));
        make.right.equalTo(self.view.mas_right).offset(-SP(50));
        make.height.mas_equalTo(SP(45));
        make.bottom.equalTo(self.view.mas_bottom).offset(-SP(70));
    }];
    
    
    [self.pushLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-SP(25));
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
}

#pragma mark - Private method

- (void)pushAction{
    PTConnectViewController *vc = [[PTConnectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)connectClick:(UIButton *)button{
    if ([self.wifiNameTextField.text isEqualToString:@""] || !self.wifiNameTextField.text) {
        [self.view makeToast:@"wifi name can not be null" duration:2.0f position:CSToastPositionCenter];
        return;
    }
    
//    PTConnectNoticeViewController *vc = [[PTConnectNoticeViewController alloc]init];
//    vc.wifiName = self.wifiNameTextField.text;
//    vc.wifiPassword = self.wifiPasswordTextField.text;
//    [self.navigationController pushViewController:vc animated:YES];
    
    
//    PTConnectStatusViewController *vc = [[PTConnectStatusViewController alloc]init];
//    vc.wifiName = self.wifiNameTextField.text;
//    vc.wifiPassword = self.wifiPasswordTextField.text;
//    [self.navigationController pushViewController:vc animated:YES];
    Request *r = [[Request alloc] init];
    r.type = Request_RequestType_Wifi;
    Request_WifiInfo *info = [[Request_WifiInfo alloc] init];
    info.ssid = self.wifiNameTextField.text;
    info.pwd = self.wifiPasswordTextField.text;
    r.wifiInfo = info;
    
    
    [manager sendValue:r];
    

}

- (void)hidePassword:(UIButton *)button{
    UIButton *btn = button;
    button.selected = !button.selected;
    if (btn.selected) {
        self.wifiPasswordTextField.secureTextEntry = NO;
    }else{
        self.wifiPasswordTextField.secureTextEntry = YES;
    }
}

- (void)showWifiStatusView{
    
//    [self.view addSubview:self.errorView];
    PTMusicServiceViewController *vc = [[PTMusicServiceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dismiss{
    [self.errorView removeFromSuperview];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.wifiNameTextField) {
        return YES;
    }else{
        return YES;
    }
}

#pragma mark - Property

- (UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleImageView.image = [UIImage imageNamed:@"icon_pentagon_1"];
    }
    return _titleImageView;
}

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.attributedText = [_noticeLabel setText:@"Input your Wi-Fi network information" withParagraphHeight:1 withKernAttributeHeight:0.5];
        _noticeLabel.font = [UIFont systemFontOfSize:SP(15)];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.textColor = k_Color_Title;

    }
    return _noticeLabel;
}

- (UILabel *)netLabel{
    if (!_netLabel) {
        _netLabel = [[UILabel alloc]init];
        _netLabel.font = [UIFont systemFontOfSize:SP(12)];
        _netLabel.textColor = k_Color_Title;
        _netLabel.text = @"Network";
    }
    return _netLabel;
}

- (MFTextField *)wifiNameTextField{
    if (!_wifiNameTextField) {
        _wifiNameTextField = [[MFTextField alloc]init];
        _wifiNameTextField.font = [UIFont systemFontOfSize:SP(12)];
        _wifiNameTextField.textColor = k_Color_SubTitle;
        _wifiNameTextField.placeholder = @"input your network";
        _wifiNameTextField.placeholderTextColor = K_Color_05;
        _wifiNameTextField.textAlignment = NSTextAlignmentLeft;
        _wifiNameTextField.delegate = self;

        _wifiNameTextField.text = @"360WiFi-Android";

        _wifiNameTextField.hasUnderline = YES;
        _wifiNameTextField.underlineColor = UIColorFromRGB(0x1F0D45);
        
        _wifiNameTextField.leftTextOffset = SP(68);
        _wifiNameTextField.textRightOffset = SP(-30);
        
        [_wifiNameTextField addSubview:self.netLabel];
        
    }
    return _wifiNameTextField;
}

- (UILabel *)passwordLabel{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc]init];
        _passwordLabel.font = [UIFont systemFontOfSize:SP(12)];
        _passwordLabel.textColor = k_Color_Title;
        _passwordLabel.text = @"Password";
    }
    return _passwordLabel;
}

- (MFTextField *)wifiPasswordTextField{
    if (!_wifiPasswordTextField) {
        _wifiPasswordTextField = [[MFTextField alloc]init];
        _wifiPasswordTextField.font = [UIFont systemFontOfSize:SP(12)];
        _wifiPasswordTextField.textColor = k_Color_SubTitle;
        _wifiPasswordTextField.placeholder = @"input your password";
        _wifiPasswordTextField.textAlignment = NSTextAlignmentLeft;
        _wifiPasswordTextField.placeholderTextColor = K_Color_05;
        _wifiPasswordTextField.delegate = self;
        _wifiPasswordTextField.secureTextEntry = YES;
        _wifiPasswordTextField.text = @"vinciohmygod";
        _wifiPasswordTextField.hasUnderline = YES;
        _wifiPasswordTextField.underlineColor = UIColorFromRGB(0x1F0D45);
        
        _wifiPasswordTextField.leftTextOffset = SP(68);
        _wifiPasswordTextField.textRightOffset = SP(-30);
        
        [_wifiPasswordTextField addSubview:self.passwordLabel];
    }
    return _wifiPasswordTextField;
}

- (UIButton *)passwordButton{
    if (!_passwordButton) {
        _passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordButton setImage:[UIImage imageNamed:@"icon_eyes_open"] forState:UIControlStateSelected];
        [_passwordButton setImage:[UIImage imageNamed:@"icon_eyes_closed"] forState:UIControlStateNormal];
        [_passwordButton addTarget:self action:@selector(hidePassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordButton;
}

- (PTButton *)connectButton{
    if (!_connectButton) {
        _connectButton = [PTButton buttonWithType:UIButtonTypeCustom];
        
        [_connectButton setTitle:@"Continue" forState:UIControlStateNormal];
        [_connectButton setTitle:@"Continue" forState:UIControlStateSelected];
        [_connectButton setTitle:@"Continue" forState:UIControlStateHighlighted];
        
        _connectButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _connectButton.enabled = YES;
        [_connectButton addTarget:self action:@selector(connectClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (PTConnectErrorView *)errorView{
    if (!_errorView) {
        _errorView = [[PTConnectErrorView alloc]initWithFrame:CGRectMake(0, __NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH, SP(42))];
        _errorView.backgroundColor = k_Color_Normal;
        __weak typeof(self) weakSelf = self;
        _errorView.dismissBlock = ^{
            [weakSelf dismiss];
        };
    }
    return _errorView;
}

- (UILabel *)pushLabel{
    if (!_pushLabel) {
        _pushLabel = [[UILabel alloc]init];
        _pushLabel.font = K_Font_02;
        _pushLabel.textAlignment = NSTextAlignmentCenter;
        _pushLabel.textColor = K_Color_05;
        _pushLabel.userInteractionEnabled = YES;
        _pushLabel.numberOfLines = 0;
        _pushLabel.text = @"Pentagon wifi have connected ? \nClick this to skip";
        @WeakObj(self);
        [_pushLabel yn_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            @StrongObj(self);
            [self pushAction];
        }];
    }
    return _pushLabel;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.wifiPasswordTextField resignFirstResponder];
    [self.wifiNameTextField resignFirstResponder];
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
