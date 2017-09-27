//
//  BluetoothManager.m
//  Pentagon_iOS
//
//  Created by LiuJiandong on 2017/8/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "BluetoothManager.h"
#define channelOnPeropheralView @"peripheralView"
#define BluetoothServiceName @"0000FF10-0000-1000-8000-00805F9B34FB"
#define BlueCharacteristicName @"0000FF11-0000-1000-8000-00805F9B34FB"

#import "SppProtocol.pbobjc.h"

@interface BluetoothManager()

@property (nonatomic, strong) CBPeripheral *currPeripheral;

@property (nonatomic, strong) CBCharacteristic *characteristic;

@property (nonatomic, strong) NSMutableArray *recevDataArr;

@property (nonatomic, strong) NSMutableArray *sendDataQuene;

@property (nonatomic, assign) Request_RequestType currentType;


@end

@implementation BluetoothManager

static BluetoothManager *share = nil ;


+(BluetoothManager *)shareInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        share = [[BluetoothManager alloc]init];
        
        [share start];
    });
    
    return share;
}

-(void)startConnectDevice:(CBPeripheral *)peripheral{
    [self showMessage:@"开始连接蓝牙"];
    //停止扫描
    [_baby cancelScan];
    
    self.currPeripheral = peripheral;
    
    [_baby AutoReconnect:self.currPeripheral];

 _baby.having(self.currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

-(void)start{
    
    _recevDataArr = [NSMutableArray arrayWithCapacity:0];
    
    _sendDataQuene = [NSMutableArray arrayWithCapacity:0];
    
    [self baby];

    [self babyDelegate];
    
    [self setUpConnetDelegate];
    
    [self beginScanBlue];
    
//    [self setUpConnetDelegate];
}


-(BabyBluetooth *)baby{
    if (!_baby) {
        _baby = [BabyBluetooth shareBabyBluetooth];
    }
    return _baby;
}

#pragma mark -蓝牙配置和操作

//蓝牙网关初始化和委托方法设置
-(void)babyDelegate{
    @WeakObj(self);
    //设置蓝牙设备开启状态
    [_baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        @StrongObj(self);
        if (central.state == CBCentralManagerStatePoweredOn) {
            debugLog(@"设备打开成功，开始扫描设备");
            [self showMessage:@"设备打开成功，开始扫描设备"];
        }
    }];
    
    
    //设置扫描到设备
    [_baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        @StrongObj(self);
//        NSLog(@"搜索到了设备:%@,%@",peripheral,peripheral.identifier.UUIDString);
        
//        @StrongObj(self);
        
//        if ([peripheral.name hasPrefix:@"Vinci"]) {name:
//            
//            
//            [self beginConnectBlueth:peripheral];
//            
//            
//        }
        if (peripheral.name.length > 0) {
            if (self.discoverBLE) {
                self.discoverBLE(central, peripheral, advertisementData, RSSI);
            }
        }
        
    }];
    
    //设置发现设备的Services的委托
    [_baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *service in peripheral.services) {
            NSLog(@"搜索到服务:%@",service.UUID.UUIDString);
        }
//        //找到cell并修改detaisText
//        for (int i=0;i<peripherals.count;i++) {
//            UITableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//            if ([cell.textLabel.text isEqualToString:peripheral.name]) {
//                cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu个service",(unsigned long)peripheral.services.count];
//            }
//        }
    }];
    //设置发现设service的Characteristics的委托
    [_baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
        
    
    }];
    //设置读取characteristics的委托
    [_baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [_baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [_baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
        
        
    }];
    
    
    //设置查找设备的过滤器
    [_baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
//        //最常用的场景是查找某一个前缀开头的设备
//        if ([peripheralName hasPrefix:@"Vinci"] ) {
//            return YES;
//        }
//        return NO;
        
        NSLog(@"name:%@,%@",peripheralName,advertisementData);
//        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length >0) {
            return YES;
        }
        return NO;
    }];
    
    
    [_baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    [_baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        
        NSLog(@"setBlockOnCancelScanBlock");
    }];
    
    
    /*设置babyOptions
     
     参数分别使用在下面这几个地方，若不使用参数则传nil
     - [centralManager scanForPeripheralsWithServices:scanForPeripheralsWithServices options:scanForPeripheralsWithOptions];
     - [centralManager connectPeripheral:peripheral options:connectPeripheralWithOptions];
     - [peripheral discoverServices:discoverWithServices];
     - [peripheral discoverCharacteristics:discoverWithCharacteristics forService:service];
     
     该方法支持channel版本:
     [baby setBabyOptionsAtChannel:<#(NSString *)#> scanForPeripheralsWithOptions:(NSDictionary *) connectPeripheralWithOptions:<#(NSDictionary *)#> scanForPeripheralsWithServices:<#(NSArray *)#> discoverWithServices:<#(NSArray *)#> discoverWithCharacteristics:(NSArray *)]
     */
    
    //示例:
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    
//    //连接设备->
//    @[[CBUUID UUIDWithString:@"00010001-574F-4F20-5370-6865726F2121"]]
    [_baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
//
  
    
    
}


-(void)setUpConnetDelegate{
    
    //设置连接代理
    
    @WeakObj(self);

    
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
    
    

    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [_baby setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        @StrongObj(self);
        if (self.connSuccessBLE) {
            self.connSuccessBLE(central, peripheral);
        }
        NSLog(@"设备：%@--连接成功",peripheral.name);
        
    }];
    
    //设置设备连接失败的委托
    [_baby setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
    }];
    
    //设置设备断开连接的委托
    [_baby setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--断开连接",peripheral.name);
        
        
        
        @StrongObj(self);
        
//        [self.baby.centralManager connectPeripheral:peripheral options:nil];
        
        
//        self.currPeripheral = nil;
//        
//        self.characteristic = nil;
        
//        [self showMessage:@"设备断开连接"];
        
//        NSLog(@"设备即将进入重新连接状态");
        
//        [self beginScanBlue];
    }];
    
    //设置发现设备的Services的委托
    [_baby setBlockOnDiscoverServicesAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, NSError *error) {
        
        @StrongObj(self);
    
        for (CBService *s in peripheral.services) {
            [self hanleOfServices:s];
        }
        
        [rhythm beats];
    }];
    
    //设置发现设service的Characteristics的委托
    [_baby setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        //插入row到tableview
    
        @StrongObj(self);
        
        
        

        
        if ([service.UUID.UUIDString isEqualToString:BluetoothServiceName]){
            
            [self disCoverCharcteris:service];

        }
        
        
    }];
    
    
    //设置读取characteristics
    [_baby setBlockOnReadValueForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"读取 characteristic name:%@ value is:%@",characteristics.UUID.UUIDString,characteristics.value);
        
        @StrongObj(self);
        
        

        
        if ([characteristics.UUID.UUIDString isEqualToString:BlueCharacteristicName]) {
            

            [self readTheCharacteristics:characteristics];

        }
    
        
    }];
    
    
    //设置发现characteristics的descriptors的委托
    [_baby setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
        
        @StrongObj(self);
        
        if ([characteristic.UUID.UUIDString isEqualToString:BlueCharacteristicName]) {
            
            
            [self readTheCharacteristics:characteristic];
            
        }
        
//        [self readTheCharacteristics:characteristic];

        
    }];
    
    
    
    //设置读取Descriptor的委托
    [_baby setBlockOnReadValueForDescriptorsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    //读取rssi的委托
    [_baby setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) {
        NSLog(@"setBlockOnDidReadRSSI:RSSI:%@",RSSI);
    }];
    
    
    //设置写数据成功的block
    [_baby setBlockOnDidWriteValueForCharacteristicAtChannel:channelOnPeropheralView block:^(CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"setBlockOnDidWriteValueForCharacteristicAtChannel characteristic:%@ and new value:%@",characteristic.UUID, characteristic.value);
    }];
    
    //设置通知状态改变的block
    [_baby setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:channelOnPeropheralView block:^(CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"uid:%@,isNotifying:%@",characteristic.UUID,characteristic.isNotifying?@"on":@"off");
    }];
    
    
    //设置beats break委托
    [rhythm setBlockOnBeatsBreak:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsBreak call");
        
        //如果完成任务，即可停止beat,返回bry可以省去使用weak rhythm的麻烦
        //        if (<#condition#>) {
        //            [bry beatsOver];
        //        }
        
    }];
    
    //设置beats over委托
    [rhythm setBlockOnBeatsOver:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsOver call");
    }];
    
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    /*连接选项->
     CBConnectPeripheralOptionNotifyOnConnectionKey :当应用挂起时，如果有一个连接成功时，如果我们想要系统为指定的peripheral显示一个提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnDisconnectionKey :当应用挂起时，如果连接断开时，如果我们想要系统为指定的peripheral显示一个断开连接的提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnNotificationKey:
     当应用挂起时，使用该key值表示只要接收到给定peripheral端的通知就显示一个提
     */
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};
    
    [_baby setBabyOptionsAtChannel:channelOnPeropheralView scanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
}

#pragma mark - 连接

-(void)beginScanBlue{
    //开始扫描蓝牙
    [_baby cancelAllPeripheralsConnection];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态。
    _baby.scanForPeripherals().begin();
}

-(void)beginConnectBlueth:(CBPeripheral *)peripheral{
    [self showMessage:@"开始连接蓝牙"];
    //停止扫描
    [_baby cancelScan];
    self.currPeripheral = peripheral;
    [_baby AutoReconnect:self.currPeripheral];
    //已经扫描到设备 开始连接蓝牙读取特征值
 _baby.having(self.currPeripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
    
}

-(void)disCoverCharcteris:(CBService *)service{
//    [self showMessage:@"发现服务"];
    self.characteristic  = service.characteristics.firstObject;
    //读取服务
    _baby.channel(channelOnPeropheralView).characteristicDetails(self.currPeripheral,self.characteristic);
}

-(void)readTheCharacteristics:(CBCharacteristic *)characteristics{
//    [self showMessage:@"读取特征值"];
    if (self.currPeripheral.state != CBPeripheralStateConnected) {
        debugLog(@"peripheral已经断开连接，请重新连接");
        return;
    }
    [self checkSendQuene];
    
    if (self.characteristic.properties & CBCharacteristicPropertyNotify ||  self.characteristic.properties & CBCharacteristicPropertyIndicate) {
        debugLog(@"启动蓝牙监听");
        if (!self.characteristic.isNotifying){
            
        }
        [self.currPeripheral setNotifyValue:true forCharacteristic:self.characteristic];
        @WeakObj(self);
        [_baby notify:self.currPeripheral characteristic:self.characteristic block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
            @StrongObj(self);
            NSLog(@"蓝牙监听 notify block, new value %@",characteristics.value);
            [self reciveNotiData:characteristics.value];
        }];
    }
}

#pragma mark - 显示消息
-(void)showMessage:(NSString *)mes{
    UIViewController *vc = [CommonMethod getCurrentVC];
    [vc.view makeToast:mes duration:1.0 position:CSToastPositionCenter];
}

#pragma mark - 发送消息
-(void)hanleOfServices:(CBService *)service{
    self.characteristic = service.characteristics.firstObject;
}

-(void)checkSendQuene{
    
//    if (_sendDataQuene.count == 0) {
//        
//        return;
//    }
//    
//    @WeakObj(self);
//    
//    [_sendDataQuene enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        @StrongObj(self);
//        
//        NSString *dataStr = (NSString *)obj;
//        
//        [self sendValue:dataStr];
//        
//        
//        
//    }];
//    
//    for (NSString *baseStr in _sendDataQuene) {
//        
//        [self sendValue:baseStr];
//    }
//    
}



-(void)sendValue:(Request *)r{
    
    self.currentType = r.type;
    

//    if (self.currPeripheral.state != CBPeripheralStateConnected) {
//        
//        debugLog(@"peripheral已经断开连接，请重新连接");
//        
//        [self showMessage:@"peripheral已经断开连接,即将重新扫描"];
//        
////        [self beginScanBlue];
//        
//        [_sendDataQuene addObject:data];
//        
//        return;
//    }
    
    
//    NSString *str = [value base64EncodedString];
//    NSString *norstr = [str base64DecodedString];
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    

    [self.currPeripheral writeValue:[r data] forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    
//    [_sendDataQuene enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        NSString *str = (NSString *)obj;
//        
//        if ([str isEqualToString:value]) {
//            
//            [_sendDataQuene removeObject:obj];
//        }
//        
//    }];
    
//    [self performSelector:@selector(checkSendQuene) withObject:nil afterDelay:1.0];
    
}

#pragma mark - 收到通知

-(void)reciveNotiData:(NSData *)data{
    NSLog(@"%@",data);
    NSError *error;
    Response *res = [Response parseFromData:data error:&error];
    if (!error && res) {
        if (res.code == Response_ResponseCode_Success) {
            if (self.currentType == Request_RequestType_Wifi) {
                [[NSNotificationCenter defaultCenter]postNotificationName:PDBabyBlueToothWIFINofification object:nil];
            }else if (self.currentType == Request_RequestType_Spotify) {
                [[NSNotificationCenter defaultCenter]postNotificationName:PDBabyBlueToothMusicNofification object:nil];
            }
        }else{
            [self showMessage:res.reason];
        }
    }
    
}





-(void)insertSectionToTableView:(CBService *)service{
    NSLog(@"搜索到服务:%@",service.UUID.UUIDString);
//    PeripheralInfo *info = [[PeripheralInfo alloc]init];
//    [info setServiceUUID:service.UUID];
//    [self.services addObject:info];
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:self.services.count-1];
//    [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)insertRowToTableView:(CBService *)service{
    
//    _services = [NSMutableArray arrayWithCapacity:0];
//    
//    [_services addObject:service];
//    
    
 
    
//    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
//    int sect = -1;
//    for (int i=0;i<self.services.count;i++) {
//        PeripheralInfo *info = [self.services objectAtIndex:i];
//        if (info.serviceUUID == service.UUID) {
//            sect = i;
//        }
//    }
//    if (sect != -1) {
//        PeripheralInfo *info =[self.services objectAtIndex:sect];
//        for (int row=0;row<service.characteristics.count;row++) {
//            CBCharacteristic *c = service.characteristics[row];
//            [info.characteristics addObject:c];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:sect];
//            [indexPaths addObject:indexPath];
//            NSLog(@"add indexpath in row:%d, sect:%d",row,sect);
//        }
////        PeripheralInfo *curInfo =[self.services objectAtIndex:sect];
////        NSLog(@"%@",curInfo.characteristics);
////        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//        
//    }
//    
    
}




@end
