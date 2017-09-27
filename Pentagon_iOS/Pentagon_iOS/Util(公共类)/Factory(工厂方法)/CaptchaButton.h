//
//  CaptchaButton.h
//
//  Created by 武建明 on 16/4/7.
//  Copyright © 2016年 Four_w. All rights reserved.
//
/**
 *验证码倒计时Btn
 */
#import "MFButton.h"

@interface CaptchaButton : MFButton
/**
 *  倒计时时间
 */
@property (assign ,nonatomic) NSInteger countdownTime;
/**
 *  按钮可点击时Title的颜色
 */
@property (strong ,nonatomic) UIColor *ableTitleColor;
/**
 *  按钮不可点击时Title的颜色
 */
@property (strong ,nonatomic) UIColor *unableTitleColor;
/**
 *  按钮可点击时背景的颜色
 */
@property (strong ,nonatomic) UIColor *ableBgColor;
/**
 *  按钮不可点击时背景的颜色
 */
@property (strong ,nonatomic) UIColor *unableBgColor;
/**
 *  开始倒计时
 */
- (void)startCountdown;
/**
 *  结束倒计时
 */
- (void)endCountdown;

@end
