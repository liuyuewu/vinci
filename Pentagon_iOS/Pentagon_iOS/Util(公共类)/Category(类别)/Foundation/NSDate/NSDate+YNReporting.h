//
//  NSDate+YNReporting.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YNReporting)


// Return a date with a specified year, month and day.
+ (NSDate *)yn_dateWithYear:(int)year month:(int)month day:(int)day;

// Return midnight on the specified date.
+ (NSDate *)yn_midnightOfDate:(NSDate *)date;

// Return midnight today.
+ (NSDate *)yn_midnightToday;

// Return midnight tomorrow.
+ (NSDate *)yn_midnightTomorrow;

// Returns a date that is exactly 1 day after the specified date. Does *not*
// zero out the time components. For example, if the specified date is
// April 15 2012 10:00 AM, the return value will be April 16 2012 10:00 AM.
+ (NSDate *)yn_oneDayAfter:(NSDate *)date;

// Returns midnight of the first day of the current, previous or next Month.
// Note: firstDayOfNextMonth returns midnight of the first day of next month,
// which is effectively the same as the "last moment" of the current month.
+ (NSDate *)yn_firstDayOfCurrentMonth;
+ (NSDate *)yn_firstDayOfPreviousMonth;
+ (NSDate *)yn_firstDayOfNextMonth;

// Returns midnight of the first day of the current, previous or next Quarter.
// Note: firstDayOfNextQuarter returns midnight of the first day of next quarter,
// which is effectively the same as the "last moment" of the current quarter.
+ (NSDate *)yn_firstDayOfCurrentQuarter;
+ (NSDate *)yn_firstDayOfPreviousQuarter;
+ (NSDate *)yn_firstDayOfNextQuarter;

// Returns midnight of the first day of the current, previous or next Year.
// Note: firstDayOfNextYear returns midnight of the first day of next year,
// which is effectively the same as the "last moment" of the current year.
+ (NSDate *)yn_firstDayOfCurrentYear;
+ (NSDate *)yn_firstDayOfPreviousYear;
+ (NSDate *)yn_firstDayOfNextYear;


- (NSDate *)yn_dateFloor;
- (NSDate *)yn_dateCeil;

- (NSDate *)yn_startOfWeek;
- (NSDate *)yn_endOfWeek;

- (NSDate *)yn_startOfMonth;
- (NSDate *)yn_endOfMonth;

- (NSDate *)yn_startOfYear;
- (NSDate *)yn_endOfYear;

- (NSDate *)yn_previousDay;
- (NSDate *)yn_nextDay;

- (NSDate *)yn_previousWeek;
- (NSDate *)yn_nextWeek;

- (NSDate *)yn_previousMonth;
- (NSDate *)yn_previousMonth:(NSUInteger) monthsToMove;
- (NSDate *)yn_nextMonth;
- (NSDate *)yn_nextMonth:(NSUInteger) monthsToMove;

#ifdef DEBUG
// For testing only. A helper function to format and display a date
// with an optional comment. For example:
//     NSDate *test = [NSDate firstDayOfCurrentMonth];
//     [test logWithComment:@"First day of current month: "];
- (void)yn_logWithComment:(NSString *)comment;
#endif



@end
