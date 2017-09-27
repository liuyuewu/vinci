//
//  NSDateFormatter+Make.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  mobile.dzone.com/news/ios-threadsafe-date-formatting

#import <Foundation/Foundation.h>

@interface NSDateFormatter (YNMake)
+(NSDateFormatter *)yn_dateFormatterWithFormat:(NSString *)format;
+(NSDateFormatter *)yn_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)yn_dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+(NSDateFormatter *)yn_dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)yn_dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)yn_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)yn_dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
@end
