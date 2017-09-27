//
//  NSDate+YNReporting.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSDate+YNReporting.h"

// Private Helper functions
@interface NSDate (Private)
+ (void)yn_zeroOutTimeComponents:(NSDateComponents **)components;
+ (NSDate *)yn_firstDayOfQuarterFromDate:(NSDate *)date;
@end

@implementation NSDate (YNReporting)

+ (NSDate *)yn_dateWithYear:(int)year month:(int)month day:(int)day {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    // Assign the year, month and day components.
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    // Zero out the hour, minute and second components.
    [self yn_zeroOutTimeComponents:&components];
    
    // Generate a valid NSDate and return it.
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    return [gregorianCalendar dateFromComponents:components];
}


+ (NSDate *)yn_midnightOfDate:(NSDate *)date {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    // Start out by getting just the year, month and day components of the specified date.
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                        fromDate:date];
    // Zero out the hour, minute and second components.
    [self yn_zeroOutTimeComponents:&components];
    
    // Convert the components back into a date and return it.
    return [gregorianCalendar dateFromComponents:components];
}

+ (NSDate *)yn_midnightToday {
    return [self yn_midnightOfDate:[NSDate date]];
}

+ (NSDate *)yn_midnightTomorrow {
    NSDate *midnightToday = [self yn_midnightToday];
    return [self yn_oneDayAfter:midnightToday];
}

+ (NSDate *)yn_oneDayAfter:(NSDate *)date {
    NSDateComponents *oneDayComponent = [[NSDateComponents alloc] init];
    [oneDayComponent setDay:1];
    
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    return [gregorianCalendar dateByAddingComponents:oneDayComponent
                                              toDate:date
                                             options:0];
}

+ (NSDate *)yn_firstDayOfCurrentMonth {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    // Start out by getting just the year, month and day components of the current date.
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                        fromDate:currentDate];
    
    // Change the Day component to 1 (for the first day of the month), and zero out the time components.
    [components setDay:1];
    [self yn_zeroOutTimeComponents:&components];
    
    return [gregorianCalendar dateFromComponents:components];
}

+ (NSDate *)yn_firstDayOfPreviousMonth {
    // Set up a "minus one month" component.
    NSDateComponents *minusOneMonthComponent = [[NSDateComponents alloc] init];
    [minusOneMonthComponent setMonth:-1];
    
    // Subtract 1 month from today's date. This gives us "one month ago today".
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    NSDate *currentDate = [NSDate date];
    NSDate *oneMonthAgoToday = [gregorianCalendar dateByAddingComponents:minusOneMonthComponent
                                                                  toDate:currentDate
                                                                 options:0];
    
    // Now extract the year, month and day components of oneMonthAgoToday.
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                        fromDate:oneMonthAgoToday];
    
    // Change the day to 1 (since we want the first day of the previous month).
    [components setDay:1];
    
    // Zero out the time components so we get midnight.
    [self yn_zeroOutTimeComponents:&components];
    
    // Finally, create a new NSDate from components and return it.
    return [gregorianCalendar dateFromComponents:components];
}

+ (NSDate *)yn_firstDayOfNextMonth {
    NSDate *firstDayOfCurrentMonth = [self yn_firstDayOfCurrentMonth];
    
    // Set up a "plus 1 month" component.
    NSDateComponents *plusOneMonthComponent = [[NSDateComponents alloc] init];
    [plusOneMonthComponent setMonth:1];
    
    // Add 1 month to firstDayOfCurrentMonth.
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    return [gregorianCalendar dateByAddingComponents:plusOneMonthComponent
                                              toDate:firstDayOfCurrentMonth
                                             options:0];
}

+ (NSDate *)yn_firstDayOfCurrentQuarter {
    return [self yn_firstDayOfQuarterFromDate:[NSDate date]];
}

+ (NSDate *)yn_firstDayOfPreviousQuarter {
    NSDate *firstDayOfCurrentQuarter = [self yn_firstDayOfCurrentQuarter];
    
    // Set up a "minus one day" component.
    NSDateComponents *minusOneDayComponent = [[NSDateComponents alloc] init];
    [minusOneDayComponent setDay:-1];
    
    // Subtract 1 day from firstDayOfCurrentQuarter.
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    NSDate *lastDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                          toDate:firstDayOfCurrentQuarter
                                                                         options:0];
    return [self yn_firstDayOfQuarterFromDate:lastDayOfPreviousQuarter];
}

+ (NSDate *)yn_firstDayOfNextQuarter {
    NSDate *firstDayOfCurrentQuarter = [self yn_firstDayOfCurrentQuarter];
    
    // Set up a "plus 3 months" component.
    NSDateComponents *plusThreeMonthsComponent = [[NSDateComponents alloc] init];
    [plusThreeMonthsComponent setMonth:3];
    
    // Add 3 months to firstDayOfCurrentQuarter.
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    return [gregorianCalendar dateByAddingComponents:plusThreeMonthsComponent
                                              toDate:firstDayOfCurrentQuarter
                                             options:0];
}

+ (NSDate *)yn_firstDayOfCurrentYear {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    // Start out by getting just the year, month and day components of the current date.
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                        fromDate:currentDate];
    
    // Change the Day and Month components to 1 (for the first day of the year), and zero out the time components.
    [components setDay:1];
    [components setMonth:1];
    [self yn_zeroOutTimeComponents:&components];
    
    return [gregorianCalendar dateFromComponents:components];
}

+ (NSDate *)yn_firstDayOfPreviousYear {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                                                        fromDate:currentDate];
    [components setDay:1];
    [components setMonth:1];
    [components setYear:components.year - 1];
    
    // Zero out the time components so we get midnight.
    [self yn_zeroOutTimeComponents:&components];
    return [gregorianCalendar dateFromComponents:components];
}

+ (NSDate *)yn_firstDayOfNextYear {
    NSDate *firstDayOfCurrentYear = [self yn_firstDayOfCurrentYear];
    
    // Set up a "plus 1 year" component.
    NSDateComponents *plusOneYearComponent = [[NSDateComponents alloc] init];
    [plusOneYearComponent setYear:1];
    
    // Add 1 year to firstDayOfCurrentYear.
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    return [gregorianCalendar dateByAddingComponents:plusOneYearComponent
                                              toDate:firstDayOfCurrentYear
                                             options:0];
}

#ifdef DEBUG
- (void)yn_logWithComment:(NSString *)comment {
    NSString *output = [NSDateFormatter localizedStringFromDate:self
                                                      dateStyle:NSDateFormatterMediumStyle
                                                      timeStyle:NSDateFormatterMediumStyle];
    NSLog(@"%@: %@", comment, output);
}
#endif

#pragma mark - Private Helper functions

+ (void)yn_zeroOutTimeComponents:(NSDateComponents **)components {
    [*components setHour:0];
    [*components setMinute:0];
    [*components setSecond:0];
}

+ (NSDate *)yn_firstDayOfQuarterFromDate:(NSDate *)date {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth
                                                        fromDate:date];
    
    NSInteger quarterNumber = floor((components.month - 1) / 3) + 1;
    // NSLog(@"Quarter number: %d", quarterNumber);
    
    NSInteger firstMonthOfQuarter = (quarterNumber - 1) * 3 + 1;
    [components setMonth:firstMonthOfQuarter];
    [components setDay:1];
    
    // Zero out the time components so we get midnight.
    [self yn_zeroOutTimeComponents:&components];
    return [gregorianCalendar dateFromComponents:components];
}



- (NSDate*) yn_dateFloor {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* dateComponents = [gregorianCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    return [gregorianCalendar dateFromComponents:dateComponents];
}

- (NSDate*) yn_dateCeil {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* dateComponents = [gregorianCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    
    return [gregorianCalendar dateFromComponents:dateComponents];
}

- (NSDate*) yn_startOfWeek {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setDay:([components day] - ([components weekday] - 1))];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*) yn_endOfWeek {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    [components setDay:([components day] + (7 - [components weekday]))];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*) yn_startOfMonth {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*) yn_endOfMonth {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    
    NSRange dayRange = [gregorianCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    [components setDay:dayRange.length];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*) yn_startOfYear {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitYear fromDate:self];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*) yn_endOfYear {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitYear fromDate:self];
    
    [components setDay:31];
    [components setMonth:12];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*) yn_previousDay {
    return [self dateByAddingTimeInterval:-86400];
}

- (NSDate*) yn_nextDay {
    return [self dateByAddingTimeInterval:86400];
}

- (NSDate*) yn_previousWeek {
    return [self dateByAddingTimeInterval:-(86400*7)];
}

- (NSDate*) yn_nextWeek {
    return [self dateByAddingTimeInterval:+(86400*7)];
}

- (NSDate*) yn_previousMonth {
    return [self yn_previousMonth:1];
}

- (NSDate*) yn_previousMonth:(NSUInteger) monthsToMove {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSInteger dayInMonth = [components day];
    
    // Update the components, initially setting the day in month to 0
    NSInteger newMonth = ([components month] - monthsToMove);
    [components setDay:1];
    [components setMonth:newMonth];
    
    // Determine the valid day range for that month
    NSDate* workingDate = [gregorianCalendar dateFromComponents:components];
    NSRange dayRange = [gregorianCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:workingDate];
    
    // Set the day clamping to the maximum number of days in that month
    [components setDay:MIN(dayInMonth, dayRange.length)];
    
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate*) yn_nextMonth {
    return [self yn_nextMonth:1];
}
+(NSCalendar*)yn_gregorianCalendar_factory{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return gregorianCalendar;
}
- (NSDate*) yn_nextMonth:(NSUInteger) monthsToMove {
    NSCalendar *gregorianCalendar = [[self class] yn_gregorianCalendar_factory];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSInteger dayInMonth = [components day];
    
    // Update the components, initially setting the day in month to 0
    NSInteger newMonth = ([components month] + monthsToMove);
    [components setDay:1];
    [components setMonth:newMonth];
    
    // Determine the valid day range for that month
    NSDate* workingDate = [gregorianCalendar dateFromComponents:components];
    NSRange dayRange = [gregorianCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:workingDate];
    
    // Set the day clamping to the maximum number of days in that month
    [components setDay:MIN(dayInMonth, dayRange.length)];
    
    return [gregorianCalendar dateFromComponents:components];
}


@end
