//
//  NSTimer+YNAddition.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (YNAddition)
/**
 *  @brief  暂停NSTimer
 */
- (void)yn_pauseTimer;
/**
 *  @brief  开始NSTimer
 */
- (void)yn_resumeTimer;
/**
 *  @brief  延迟开始NSTimer
 */
- (void)yn_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
