//
//  PTConnectProgressView.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTConnectProgressView : UIView

@property (assign, nonatomic) CGFloat progress;
- (void)startConnect;
- (void)resume;

@end
