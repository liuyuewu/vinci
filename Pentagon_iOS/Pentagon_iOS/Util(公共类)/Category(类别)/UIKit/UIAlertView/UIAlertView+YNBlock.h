//
//  UIAlertView+Block.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by 符现超 on 15/5/9.
//  Copyright (c) 2015年 http://weibo.com/u/1655766025 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewYNCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (YNBlock)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewYNCallBackBlock yn_alertViewCallBackBlock;

+ (void)yn_alertWithCallBackBlock:(UIAlertViewYNCallBackBlock)alertViewCallBackBlock
                            title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName
                otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
