//
//  PTBodyCommonView.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PTConnectStatus){
    PTConnectSuccessStatus = 0,
    PTDisConnectStatus
};

@interface PTBodyCommonView : UIView

@property (copy, nonatomic)void (^wifiBlock)();
@property (copy, nonatomic)void (^musicBlock)();

- (void)updateViewWithConnectStatus:(PTConnectStatus)status;

@end
