//
//  PTConnectViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTConnectViewController.h"
#import "PTMusicServiceViewController.h"

#import "PTBodyConnectView.h"
#import "PTBeginConnectViewController.h"
#import "PTAlertView.h"


@interface PTConnectViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) PTBodyConnectView *connectView;


@end

@implementation PTConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"Pentagon";
    [self.view addSubview:self.connectView];
    
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"Pair new Device" forState:UIControlStateNormal];

    __weak typeof(self) weakSelf = self;
    self.connectView.musicServiceBlock = ^{
        PTMusicServiceViewController *vc = [[PTMusicServiceViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    // Do any additional setup after loading the view.
}


- (void)rightClick{
    PTAlertView *alert = [PTAlertView alertView];
    alert.alertType = PTNoticeAlertView;
    alert.message = @"Are you want to pair a new device?";
    
    @WeakObj(self);
    alert.completeBlock = ^{
        @StrongObj(self);
        [self pairDeviceAction];
    };
    [alert show];
}

- (void)pairDeviceAction{
    NSString *headsetID = [NSUserDefaults yn_stringForKey:PTGoogleHeaderIDKey];
    NSLog(@"head set id = %@",headsetID);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"waiting";
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    
//    [[[self.ref child:@"headwificonfigs"]child:headsetID]setValue:@{@"headset_id":headsetID,@"timestamp":[NSNumber numberWithDouble:a],@"isconfig":[NSNumber numberWithInteger:0]} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
//        
//        if (error) {
//            NSLog(@"error = %@",error);
//            [hud hideAnimated:YES];
//            [self.view makeToast:@"reset error" duration:2.0f position:CSToastPositionCenter];
//        }else{
//            [hud hideAnimated:YES];
//            [self removeAllKey];
//            PTBeginConnectViewController *vc = [[PTBeginConnectViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//            NSLog(@"reset success");
//        }
//    }];
    
    
    PTBeginConnectViewController *vc = [[PTBeginConnectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"spotify = %@  alexa = %@",[NSUserDefaults yn_stringForKey:PTSpotifyAccessToken],[NSUserDefaults yn_stringForKey:PTAlexaAccessToken]);
    
    if ([[NSUserDefaults yn_stringForKey:PTSpotifyAccessToken] isEqualToString:@""]&& [[NSUserDefaults yn_stringForKey:PTAlexaAccessToken] isEqualToString:@""]) {
        _connectView.connectStatus = WifiOnlyConnectStatus;
    }else{
        _connectView.connectStatus = WifiAndMusicServiceStatus;
    }
    
    [self removeController];
    self.leftButton.hidden = YES;
}



- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.connectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(__NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Property

- (PTBodyConnectView *)connectView{
    if (!_connectView) {
        _connectView = [[PTBodyConnectView alloc]init];
    }
    return _connectView;
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
