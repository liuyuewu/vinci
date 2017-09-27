//
//  PTBodyConnectView.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ConnectStatus){
    WifiOnlyConnectStatus = 0,
    WifiAndMusicServiceStatus = 1
};

@interface PTBodyConnectView : UIView

@property (assign, nonatomic) ConnectStatus connectStatus;

@property (copy, nonatomic) void (^musicServiceBlock)();
@property (copy, nonatomic) void (^chooseNetworkBlock)();

@end
