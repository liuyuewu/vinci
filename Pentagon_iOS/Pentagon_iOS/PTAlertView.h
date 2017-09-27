//
//  PTAlertView.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/7/11.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PTAlertViewType){
    PTTipAlertView = 0,
    PTNoticeAlertView,
};

@interface PTAlertView : UIView

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *cancelTitle;
@property (strong, nonatomic) NSString *nextTitle;

@property (assign, nonatomic) PTAlertViewType alertType;

@property (copy, nonatomic) void (^completeBlock)();

+ (instancetype)alertView;
- (void)show;

@end
