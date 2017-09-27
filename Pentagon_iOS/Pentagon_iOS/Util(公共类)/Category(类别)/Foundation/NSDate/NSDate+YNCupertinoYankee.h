//
//  NSDate+YNCurpertinoYankee.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YNCupertinoYankee)


///---------------------------------------
/// @name Calculate Beginning / End of Day
///---------------------------------------

/**
 
 */
- (NSDate *)yn_beginningOfDay;

/**
 
 */
- (NSDate *)yn_endOfDay;

///----------------------------------------
/// @name Calculate Beginning / End of Week
///----------------------------------------

/**
 
 */
- (NSDate *)yn_beginningOfWeek;

/**
 
 */
- (NSDate *)yn_endOfWeek;

///-----------------------------------------
/// @name Calculate Beginning / End of Month
///-----------------------------------------

/**
 
 */
- (NSDate *)yn_beginningOfMonth;

/**
 
 */
- (NSDate *)yn_endOfMonth;

///----------------------------------------
/// @name Calculate Beginning / End of Year
///----------------------------------------

/**
 
 */
- (NSDate *)yn_beginningOfYear;

/**
 
 */
- (NSDate *)yn_endOfYear;


@end
