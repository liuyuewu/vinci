//
//  NSDate+YNFormatter.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YNFormatter)

+(NSDateFormatter *)yn_formatter;
+(NSDateFormatter *)yn_formatterWithoutTime;
+(NSDateFormatter *)yn_formatterWithoutDate;

-(NSString *)yn_formatWithUTCTimeZone;
-(NSString *)yn_formatWithLocalTimeZone;
-(NSString *)yn_formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)yn_formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)yn_formatWithUTCTimeZoneWithoutTime;
-(NSString *)yn_formatWithLocalTimeZoneWithoutTime;
-(NSString *)yn_formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)yn_formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)yn_formatWithUTCWithoutDate;
-(NSString *)yn_formatWithLocalTimeWithoutDate;
-(NSString *)yn_formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)yn_formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)yn_currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)yn_dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)yn_dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)yn_dateWithFormat:(NSString *)format;

@end
