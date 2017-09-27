//
//  BluetoothManager.h
//  Pentagon_iOS
//
//  Created by LiuJiandong on 2017/8/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BabyBluetooth.h"
@class Request;
/*
 
 <F>   <A>  <1>          <1>
 <>   <1>  <2>          <1>
 ————  ————  ————————    ————————
 起始位  网络  0.无分类      0成功
 音乐  1.Spotify    错误1, 错误2...
 音乐  2.Alex
 
 */

@interface BluetoothManager : NSObject
    

@property (nonatomic, strong) BabyBluetooth *baby;
///发现蓝牙的回调
@property (nonatomic, copy) void (^discoverBLE)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI);
///连接蓝牙成功的回调
@property (nonatomic, copy) void (^connSuccessBLE)(CBCentralManager *central, CBPeripheral *peripheral);

+(BluetoothManager *)shareInstance;



-(void)startConnectDevice:(CBPeripheral *)peripheral;

-(void)sendValue:(Request *)r;



@end
