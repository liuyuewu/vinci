//
//  PTChooseWiFIViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTChooseWiFIViewController.h"
#import "PTConnectWiFiViewController.h"
#import "PTWiFiHandler.h"
#import "PTWifiCell.h"


#import <NetworkExtension/NetworkExtension.h>

@interface PTChooseWiFIViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *rescanButton;
@property (strong, nonatomic) UILabel *bottomLabel;

@end

@implementation PTChooseWiFIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self.view addSubview:self.noticeLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomLabel];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.rescanButton];
    
    [PTChooseWiFIViewController getWifiList];
    
    
    // Do any additional setup after loading the view.
}

+(void)getWifiList{
    
    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    [options setObject:@"🔑😀新网程-点我上网😀🔑" forKey:kNEHotspotHelperOptionDisplayName];
    
    dispatch_queue_t queue = dispatch_queue_create("com.pronetwayXY", NULL);
    BOOL returnType = [NEHotspotHelper registerWithOptions:options queue:queue handler: ^(NEHotspotHelperCommand * cmd) {
        NEHotspotNetwork* network;
        NSLog(@"COMMAND TYPE:   %ld", (long)cmd.commandType);
        [cmd createResponse:kNEHotspotHelperResultAuthenticationRequired];
        if (cmd.commandType == kNEHotspotHelperCommandTypeEvaluate || cmd.commandType ==kNEHotspotHelperCommandTypeFilterScanList) {
            NSLog(@"WIFILIST:   %@", cmd.networkList);
            for (network  in cmd.networkList) {
                // NSLog(@"COMMAND TYPE After:   %ld", (long)cmd.commandType);
                if ([network.SSID isEqualToString:@"ssid"]|| [network.SSID isEqualToString:@"proict_test"]) {
                    
                    double signalStrength = network.signalStrength;
                    NSLog(@"Signal Strength: %f", signalStrength);
                    [network setConfidence:kNEHotspotHelperConfidenceHigh];
                    [network setPassword:@"password"];
                    
                    NEHotspotHelperResponse *response = [cmd createResponse:kNEHotspotHelperResultSuccess];
                    NSLog(@"Response CMD %@", response);
                    
                    [response setNetworkList:@[network]];
                    [response setNetwork:network];
                    [response deliver];
                }
            }
        }
    }];
    NSLog(@"result :%d", returnType);
    NSArray *array = [NEHotspotHelper supportedNetworkInterfaces];
    NSLog(@"wifiArray:%@", array);
    NEHotspotNetwork *connectedNetwork = [array lastObject];
    NSLog(@"supported Network Interface: %@", connectedNetwork);
    
}

- (void)setupNavigation{
    self.titleLabel.text = @"Pentagon WiFi setup";
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(20));
        make.bottom.equalTo(self.view.mas_bottom).offset(-14);
        make.right.equalTo(self.view.mas_right).offset(-SP(20));
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SP(33));
        make.bottom.equalTo(self.bottomLabel.mas_top).offset(-SP(17));
    }];
    
    [self.rescanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-SP(33));
        make.bottom.equalTo(self.bottomLabel.mas_top).offset(-SP(17));
    }];
    
}

- (void)cancelClick:(UIButton *)button{
    [self.view makeToast:@"cancel click"];
}

- (void)rescanClick:(UIButton *)button{
    [self.view makeToast:@"rescan click"];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTWifiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WifiCell"];
    if (cell == nil) {
        cell = [[PTWifiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WifiCell"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PTWifiCell *cell = (PTWifiCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    PTConnectWiFiViewController *vc = [[PTConnectWiFiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Property

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SP(31), SP(22) + __NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH - 2*SP(31), SP(25))];
        _noticeLabel.font = [UIFont systemFontOfSize:SP(18)];
        _noticeLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _noticeLabel.text = @"Select your Wi-Fi network";
    }
    return _noticeLabel;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(SP(34),__NAVIGATION_BAR_HEIGHT + SP(70), __SCREEN_WIDTH - 2 * SP(34), __SCREEN_HEIGHT - SP(128) - SP(134)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"cancel setup" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:UIColorFromRGB(0x5f9397) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)rescanButton{
    if (!_rescanButton) {
        _rescanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rescanButton setTitle:@"rescan" forState:UIControlStateNormal];
        [_rescanButton setTitleColor:UIColorFromRGB(0x5f9397) forState:UIControlStateNormal];
        [_rescanButton addTarget:self action:@selector(rescanClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rescanButton;
}

- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = [NSString stringWithFormat:@"Your Pentagon MAC Address:%@",[PTWiFiHandler currentMACAddress]];
        _bottomLabel.font = [UIFont systemFontOfSize:SP(14)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _bottomLabel.numberOfLines = 0;
    }
    return _bottomLabel;
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
