//
//  NSDate+YNUtilities.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#define D_MINUTE	60
#define D_HOUR	3600
#define D_DAY	86400
#define D_WEEK	604800
#define D_YEAR	31556926

@interface NSDate (YNUtilities)

+ (NSCalendar *)yn_currentCalendar; // avoid bottlenecks
#pragma mark ---- Decomposing dates 分解的日期
@property (readonly) NSInteger yn_nearestHour;
@property (readonly) NSInteger yn_hour;
@property (readonly) NSInteger yn_minute;
@property (readonly) NSInteger yn_seconds;
@property (readonly) NSInteger yn_day;
@property (readonly) NSInteger yn_month;
@property (readonly) NSInteger yn_week;
@property (readonly) NSInteger yn_weekday;
@property (readonly) NSInteger yn_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger yn_year;

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *yn_shortString;
@property (nonatomic, readonly) NSString *yn_shortDateString;
@property (nonatomic, readonly) NSString *yn_shortTimeString;
@property (nonatomic, readonly) NSString *yn_mediumString;
@property (nonatomic, readonly) NSString *yn_mediumDateString;
@property (nonatomic, readonly) NSString *yn_mediumTimeString;
@property (nonatomic, readonly) NSString *yn_longString;
@property (nonatomic, readonly) NSString *yn_longDateString;
@property (nonatomic, readonly) NSString *yn_longTimeString;

///使用dateStyle timeStyle格式化时间
- (NSString *)yn_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
///给定format格式化时间
- (NSString *)yn_stringWithFormat:(NSString *)format;

#pragma mark ---- 从当前日期相对日期时间
///明天
+ (NSDate *)yn_dateTomorrow;
///昨天
+ (NSDate *)yn_dateYesterday;
///今天后几天
+ (NSDate *)yn_dateWithDaysFromNow:(NSInteger)days;
///今天前几天
+ (NSDate *)yn_dateWithDaysBeforeNow:(NSInteger)days;
///当前小时后dHours个小时
+ (NSDate *)yn_dateWithHoursFromNow:(NSInteger)dHours;
///当前小时前dHours个小时
+ (NSDate *)yn_dateWithHoursBeforeNow:(NSInteger)dHours;
///当前分钟后dMinutes个分钟
+ (NSDate *)yn_dateWithMinutesFromNow:(NSInteger)dMinutes;
///当前分钟前dMinutes个分钟
+ (NSDate *)yn_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark ---- Comparing dates 比较时间
///比较年月日是否相等
- (BOOL)yn_isEqualToDateIgnoringTime:(NSDate *)aDate;
///是否是今天
- (BOOL)yn_isToday;
///是否是明天
- (BOOL)yn_isTomorrow;
///是否是昨天
- (BOOL)yn_isYesterday;

///是否是同一周
- (BOOL)yn_isSameWeekAsDate:(NSDate *)aDate;
///是否是本周
- (BOOL)yn_isThisWeek;
///是否是本周的下周
- (BOOL)yn_isNextWeek;
///是否是本周的上周
- (BOOL)yn_isLastWeek;

///是否是同一月
- (BOOL)yn_isSameMonthAsDate:(NSDate *)aDate;
///是否是本月
- (BOOL)yn_isThisMonth;
///是否是本月的下月
- (BOOL)yn_isNextMonth;
///是否是本月的上月
- (BOOL)yn_isLastMonth;

///是否是同一年
- (BOOL)yn_isSameYearAsDate:(NSDate *)aDate;
///是否是今年
- (BOOL)yn_isThisYear;
///是否是今年的下一年
- (BOOL)yn_isNextYear;
///是否是今年的上一年
- (BOOL)yn_isLastYear;

///是否提前aDate
- (BOOL)yn_isEarlierThanDate:(NSDate *)aDate;
///是否晚于aDate
- (BOOL)yn_isLaterThanDate:(NSDate *)aDate;
///是否晚是未来
- (BOOL)yn_isInFuture;
///是否晚是过去
- (BOOL)yn_isInPast;


///是否是工作日
- (BOOL)yn_isTypicallyWorkday;
///是否是周末
- (BOOL)yn_isTypicallyWeekend;

#pragma mark ---- Adjusting dates 调节时间
///增加dYears年
- (NSDate *)yn_dateByAddingYears:(NSInteger)dYears;
///减少dYears年
- (NSDate *)yn_dateBySubtractingYears:(NSInteger)dYears;
///增加dMonths月
- (NSDate *)yn_dateByAddingMonths:(NSInteger)dMonths;
///减少dMonths月
- (NSDate *)yn_dateBySubtractingMonths:(NSInteger)dMonths;
///增加dDays天
- (NSDate *)yn_dateByAddingDays:(NSInteger)dDays;
///减少dDays天
- (NSDate *)yn_dateBySubtractingDays:(NSInteger)dDays;
///增加dHours小时
- (NSDate *)yn_dateByAddingHours:(NSInteger)dHours;
///减少dHours小时
- (NSDate *)yn_dateBySubtractingHours:(NSInteger)dHours;
///增加dMinutes分钟
- (NSDate *)yn_dateByAddingMinutes:(NSInteger)dMinutes;
///减少dMinutes分钟
- (NSDate *)yn_dateBySubtractingMinutes:(NSInteger)dMinutes;


#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)yn_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)yn_minutesBeforeDate:(NSDate *)aDate;
///比aDate晚多少小时
- (NSInteger)yn_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)yn_hoursBeforeDate:(NSDate *)aDate;
///比aDate晚多少天
- (NSInteger)yn_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)yn_daysBeforeDate:(NSDate *)aDate;

///与anotherDate间隔几天
- (NSInteger)yn_distanceDaysToDate:(NSDate *)anotherDate;
///与anotherDate间隔几月
- (NSInteger)yn_distanceMonthsToDate:(NSDate *)anotherDate;
///与anotherDate间隔几年
- (NSInteger)yn_distanceYearsToDate:(NSDate *)anotherDate;


@end
