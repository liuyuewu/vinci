//
//  NSDate+YNExtension.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YNExtension)

/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)yn_day;
- (NSUInteger)yn_month;
- (NSUInteger)yn_year;
- (NSUInteger)yn_hour;
- (NSUInteger)yn_minute;
- (NSUInteger)yn_second;
+ (NSUInteger)yn_day:(NSDate *)date;
+ (NSUInteger)yn_month:(NSDate *)date;
+ (NSUInteger)yn_year:(NSDate *)date;
+ (NSUInteger)yn_hour:(NSDate *)date;
+ (NSUInteger)yn_minute:(NSDate *)date;
+ (NSUInteger)yn_second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)yn_daysInYear;
+ (NSUInteger)yn_daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)yn_isLeapYear;
+ (BOOL)yn_isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)yn_weekOfYear;
+ (NSUInteger)yn_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)yn_formatYMD;
+ (NSString *)yn_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)yn_weeksOfMonth;
+ (NSUInteger)yn_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)yn_begindayOfMonth;
+ (NSDate *)yn_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)yn_lastdayOfMonth;
+ (NSDate *)yn_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)yn_dateAfterDay:(NSUInteger)day;
+ (NSDate *)yn_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)yn_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)yn_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)yn_offsetYears:(int)numYears;
+ (NSDate *)yn_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)yn_offsetMonths:(int)numMonths;
+ (NSDate *)yn_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)yn_offsetDays:(int)numDays;
+ (NSDate *)yn_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)yn_offsetHours:(int)hours;
+ (NSDate *)yn_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)yn_daysAgo;
+ (NSUInteger)yn_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)yn_weekday;
+ (NSInteger)yn_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)yn_dayFromWeekday;
+ (NSString *)yn_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)yn_isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)yn_isToday;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)yn_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)yn_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)yn_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)yn_stringWithFormat:(NSString *)format;
+ (NSDate *)yn_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)yn_daysInMonth:(NSUInteger)month;
+ (NSUInteger)yn_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)yn_daysInMonth;
+ (NSUInteger)yn_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)yn_timeInfo;
+ (NSString *)yn_timeInfoWithDate:(NSDate *)date;
+ (NSString *)yn_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)yn_ymdFormat;
- (NSString *)yn_hmsFormat;
- (NSString *)yn_ymdHmsFormat;
+ (NSString *)yn_ymdFormat;
+ (NSString *)yn_hmsFormat;
+ (NSString *)yn_ymdHmsFormat;


@end
