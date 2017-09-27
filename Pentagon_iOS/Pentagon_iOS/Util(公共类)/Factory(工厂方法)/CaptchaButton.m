//
//  CaptchaButton.m
//  SSSS
//
//  Created by 武建明 on 16/4/7.
//  Copyright © 2016年 Four_w. All rights reserved.
//

#import "CaptchaButton.h"

@interface CaptchaButton ()


@end

@implementation CaptchaButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.countdownTime = 59;
        self.ableBgColor = K_Color_Clear;
        self.ableTitleColor = K_Color_01;
        self.unableBgColor = K_Color_Clear;
        self.unableTitleColor = K_Color_05;
        [self setTitleColor:self.ableTitleColor forState:UIControlStateNormal];
    }
    return self;
}
#pragma mark - 验证码倒计时开始
- (void)startCountdown
{
//    __block NSInteger timeout = self.countdownTime; //倒计时时间
    self.countdownTime = 59;

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(self.countdownTime<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:@"重新发送" forState:UIControlStateNormal];
                [self setTitleColor:self.ableTitleColor forState:UIControlStateNormal];
                [self setBackgroundColor:self.ableBgColor];
                self.userInteractionEnabled = YES;
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = self.countdownTime % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                [self setTitleColor:self.unableTitleColor forState:UIControlStateNormal];
                [self setBackgroundColor:self.unableBgColor];
                self.userInteractionEnabled = NO;
            });
            self.countdownTime--;
        }
    });
    dispatch_resume(_timer);
    

}
- (void)endCountdown
{
    self.countdownTime = 0;
}

@end
