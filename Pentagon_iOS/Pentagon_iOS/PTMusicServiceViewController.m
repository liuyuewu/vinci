//
//  PTMusicServiceViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTMusicServiceViewController.h"
#import "PTMusicServiceCell.h"
#import "PTWebViewViewController.h"
#import "PTAlertView.h"
#import "BluetoothManager.h"
#import "PTMusicSeriveModel.h"


@interface PTMusicServiceViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *noticeLabel;
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) NSMutableArray *musicSeriveArr;
@property (strong, nonatomic) PTMusicSeriveModel *loginModel;
@property (strong, nonatomic) PTMusicSeriveModel *willLoginModel;
@property (strong, nonatomic) BluetoothManager *manager;

@end

@implementation PTMusicServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self initMusicSeriverArr];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noticeLabel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bluetoothReceiveData:) name:PDBabyBlueToothMusicNofification object:nil];
    
}
- (void)initMusicSeriverArr{
    [NSUserDefaults yn_setBool:NO forKey:PTSpotifyLogin];
    PTMusicSeriveModel *spotifyModel = [[PTMusicSeriveModel alloc] init];
    spotifyModel.name = @"Spotify";
    spotifyModel.login = [NSUserDefaults yn_boolForKey:PTSpotifyLogin];
    [self.musicSeriveArr addObject:spotifyModel];
    if ([NSUserDefaults yn_boolForKey:PTSpotifyLogin]) {
        self.loginModel = spotifyModel;
    }
    
    PTMusicSeriveModel *soundCloudModel = [[PTMusicSeriveModel alloc] init];
    soundCloudModel.name = @"SoundCloud";
    soundCloudModel.login = [NSUserDefaults yn_boolForKey:PTSoundCloudLogin];
    [self.musicSeriveArr addObject:soundCloudModel];
    if ([NSUserDefaults yn_boolForKey:PTSoundCloudLogin]) {
        self.loginModel = soundCloudModel;
    }
    
    PTMusicSeriveModel *alexaModel = [[PTMusicSeriveModel alloc] init];
    alexaModel.name = @"Amazon Alexa";
    alexaModel.login = [NSUserDefaults yn_boolForKey:PTAlexaLogin];
    [self.musicSeriveArr addObject:alexaModel];
    if ([NSUserDefaults yn_boolForKey:PTAlexaLogin]) {
        self.loginModel = alexaModel;
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self removeController];
    self.leftButton.hidden = YES;
}

- (void)setupNavigation{
    self.titleLabel.text = @"Music Service";
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SP(80);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.musicSeriveArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTMusicServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicServiceCell"];
    if (cell == nil) {
        cell = [[PTMusicServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MusicServiceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PTMusicSeriveModel *model = self.musicSeriveArr[indexPath.section];
    cell.model = model;
    return cell;
}

- (void)pushToWebVCWithType:(MusicServiceType)type{
    PTWebViewViewController *vc = [[PTWebViewViewController alloc]init];
    @WeakObj(self);
    [vc setLoginService:^(Request *r, MusicServiceType type) {
        @StrongObj(self);
        PTMusicSeriveModel *model;
        if (type == MusicServiceTypeSpotify) {
            model = self.musicSeriveArr[0];
        }else if (type == MusicServiceTypeSoundCloud) {
            model = self.musicSeriveArr[1];
        }else if (type == MusicServiceTypeAlexa) {
            model = self.musicSeriveArr[2];
        }
        model.login = YES;
        self.loginModel = model;
        [self.tableView reloadData];
    }];
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
}
///点击cell是先判断该服务是否已经登录，如果登录，则不做处理
///如果该服务未登录，先判断是否有其他方式登录了，如果有先提示退出，在登录，否则清理cookie进行登录
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PTMusicSeriveModel *model = self.musicSeriveArr[indexPath.section];
    if (model == self.loginModel) {
        return;
    }else{
        if (self.loginModel) {
            self.willLoginModel = model;
            [self logoutMusicService:self.loginModel];
        }else{
            [self cleanCookie];
            [self loginWithModel:model];
        }
    }
}


- (void)logoutMusicService:(PTMusicSeriveModel *)model{
    PTAlertView *alert = [PTAlertView alertView];
    alert.alertType = PTNoticeAlertView;
    alert.message = [NSString stringWithFormat:@"Are you sure you want to log out %@",model.name];
    
    @WeakObj(self);
    alert.completeBlock = ^{
        @StrongObj(self);
        [NSUserDefaults removeObjcFromDefaultWithKey:PTSpotifyLogin];
        [NSUserDefaults removeObjcFromDefaultWithKey:PTSoundCloudLogin];
        [NSUserDefaults removeObjcFromDefaultWithKey:PTAlexaLogin];
        model.login = NO;
        self.loginModel = nil;
        [self cleanCookie];
        [self.view makeToast:@"log out success" duration:1.0f position:CSToastPositionCenter];
        [self.tableView reloadData];
        [self loginWithModel:self.willLoginModel];
    };
    [alert show];
}

- (void)loginWithModel:(PTMusicSeriveModel *)model{
    if ([model.name isEqualToString:@"Spotify"]) {
        [self pushToWebVCWithType:MusicServiceTypeSpotify];
    }else if ([model.name isEqualToString:@"SoundCloud"]) {
        [self pushToWebVCWithType:MusicServiceTypeSoundCloud];
    }else{
        [self pushToWebVCWithType:MusicServiceTypeAlexa];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH, 14)];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 14.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

#pragma mark - Private method

-(void)uploadVINCIByBluetooth:(Request *)r{
    MBProgressHUD *hun = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hun.label.text = @"waiting";
    [self.manager sendValue:r];
}


- (void)cleanCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
}

#pragma mark - 通知服务
-(void)bluetoothReceiveData:(NSNotification *)noti{
    debugLog(@"收到蓝牙通知");
    NSString *reStr = (NSString *)noti.object;
    if (reStr.length != 4) {
        return;
    }
    if ([reStr characterAtIndex:0] == 'F') {
        if ([reStr characterAtIndex:1] == 'B' && [reStr characterAtIndex:3] == '1') {
            if ([reStr characterAtIndex:3] == '1') {
                debugLog(@"蓝牙监听设置音乐服务成功");
                if ([reStr characterAtIndex:2] == '1') {
                    //spotify
                    [self.view makeToast:@"Authorization success" duration:2.0f position:CSToastPositionCenter];
                }else if ([reStr characterAtIndex:2] == '2') {
                    //Alex
                    
                    [self.view makeToast:@"Authorization success" duration:2.0f position:CSToastPositionCenter];
                }
                [self.tableView reloadData];
            }else{
                [self.view makeToast:@"Authorization failed" duration:2.0f position:CSToastPositionCenter];
            }
        }
    }
}

#pragma mark - Property

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, __NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH, __SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = K_Color_Clear;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,__SCREEN_HEIGHT - 45, __SCREEN_WIDTH - 2*20, 20)];
        _noticeLabel.text = @"You can only select one account at the same time";
        _noticeLabel.font = [UIFont systemFontOfSize:14];
        _noticeLabel.textColor = UIColorFromRGB(0x4a4a4a);
    }
    return _noticeLabel;
}

- (NSMutableArray *)musicSeriveArr{
    if (!_musicSeriveArr) {
        _musicSeriveArr = [NSMutableArray arrayWithCapacity:3];
    }
    return _musicSeriveArr;
}

- (BluetoothManager *)manager{
    if (!_manager) {
        _manager = [BluetoothManager shareInstance];
    }
    return _manager;
}


@end
