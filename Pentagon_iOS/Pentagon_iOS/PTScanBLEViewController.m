//
//  PTScanBLEViewController.m
//  Pentagon_iOS
//
//  Created by Vinci on 2017/9/20.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTScanBLEViewController.h"
#import "BluetoothManager.h"
#import "PTButton.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "PTBleTableViewCell.h"
#import "PTConnectSuccessViewController.h"
#import "BluetoothManager.h"

#define channelOnPeropheralView @"peripheralView"
@interface PTScanBLEViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *peripheralDataArray;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PTButton *searchButton;
@property (strong, nonatomic) BluetoothManager *manager;

@end

@implementation PTScanBLEViewController

static NSString *identify = @"PTBleTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchButton];
    peripheralDataArray = [NSMutableArray array];
   
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(method) userInfo:nil repeats:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
//    停止之前的连接
    [self connectBLE];
}
- (void)setupNavigation{
    self.titleLabel.text = @"Step 2";
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-SP(22));
        make.left.equalTo(self.view.mas_left).offset(SP(50));
        make.right.equalTo(self.view.mas_right).offset(-SP(50));
        make.height.mas_equalTo(44);
    }];
    
    
    
}

-(void)connectBLE{
    self.manager = [BluetoothManager shareInstance];
    //初始化BabyBluetooth 蓝牙库
    __weak typeof(self) weakSelf = self;
    [self.manager setDiscoverBLE:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI){
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
    [self.manager setConnSuccessBLE:^(CBCentralManager *central, CBPeripheral *peripheral){
        [weakSelf pushNextBleStatusSuccessVC];
    }];
}

#pragma mark -蓝牙配置和操作

//蓝牙网关初始化和委托方法设置
-(void)babyDelegate{
    
   
    
    
    
//    [baby setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
//        [weakSelf.view hideToasts];
//        [self pushNextBleStatusSuccessVC];
//        NSLog(@"设备：%@--连接成功",peripheral.name);
//    }];
//    
//    //设置设备连接失败的委托
//    [baby setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
//        [weakSelf.view hideToasts];
//        NSLog(@"设备：%@--连接失败",peripheral.name);
//    }];
    
}

#pragma mark -UIViewController 方法
//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSArray *peripherals = [peripheralDataArray valueForKey:@"peripheral"];
    if(![peripherals containsObject:peripheral]) {
//        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
//        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];
        [item setValue:advertisementData forKey:@"advertisementData"];
        [peripheralDataArray addObject:item];
        [self.tableView reloadData];
//        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return peripheralDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SP(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PTBleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[PTBleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.bleInfo = item;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    [self.manager startConnectDevice:peripheral];
    
}
- (void)pushNextBleStatusSuccessVC{
    PTConnectSuccessViewController *vc = [[PTConnectSuccessViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PDBabyBlueToothNofification object:nil];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,__NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH, __SCREEN_HEIGHT - __NAVIGATION_BAR_HEIGHT - 44 - SP(22)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}



- (PTButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [PTButton buttonWithType:UIButtonTypeCustom];
        
        [_searchButton setTitle:@"Continue" forState:UIControlStateNormal];
        [_searchButton setTitle:@"Continue" forState:UIControlStateSelected];
        [_searchButton setTitle:@"Continue" forState:UIControlStateHighlighted];
        
        _searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _searchButton.enabled = YES;
//        [_searchButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}


@end
