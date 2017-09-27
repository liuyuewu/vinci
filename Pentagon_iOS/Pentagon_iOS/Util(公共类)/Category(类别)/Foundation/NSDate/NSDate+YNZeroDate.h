//
//  NSDate+YNZeroDate.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YNZeroDate)

+ (NSDate *)yn_zeroTodayDate;
+ (NSDate *)yn_zero24TodayDate;

- (NSDate *)yn_zeroDate;
- (NSDate *)yn_zero24Date;

@end
