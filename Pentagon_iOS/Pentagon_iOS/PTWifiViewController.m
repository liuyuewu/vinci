//
//  PTWifiViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTWifiViewController.h"
#import "PTChooseWiFIViewController.h"
#import "PTConnectWiFiViewController.h"
#import "PTWiFiSearchView.h"

@interface PTWifiViewController ()

@property (strong, nonatomic) PTWiFiSearchView *searchView;

@end

@implementation PTWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self.view addSubview:self.searchView];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(__NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    self.searchView.connectBlock = ^{
        PTConnectWiFiViewController *vc = [[PTConnectWiFiViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    // Do any additional setup after loading the view.
}

- (void)setupNavigation{
    self.titleLabel.text = @"Pentagon Wifi setup";
}

#pragma mark - Perperty

- (PTWiFiSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[PTWiFiSearchView alloc]init];
    }
    return _searchView;
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
