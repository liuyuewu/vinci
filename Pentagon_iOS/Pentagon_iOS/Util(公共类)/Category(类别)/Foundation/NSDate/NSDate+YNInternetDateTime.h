//
//  NSDate+YNInternetDateTime.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

// Formatting hints
typedef enum {
    DateFormatHintNone,
    DateFormatHintRFC822,
    DateFormatHintRFC3339
} DateFormatHint;

@interface NSDate (YNInternetDateTime)

// Get date from RFC3339 or RFC822 string
// - A format/specification hint can be used to speed up,
//   otherwise both will be attempted in order to get a date
+ (NSDate *)yn_dateFromInternetDateTimeString:(NSString *)dateString
                                   formatHint:(DateFormatHint)hint;

// Get date from a string using a specific date specification
+ (NSDate *)yn_dateFromRFC3339String:(NSString *)dateString;
+ (NSDate *)yn_dateFromRFC822String:(NSString *)dateString;

@end
