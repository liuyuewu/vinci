//
//  NSString+YNMatcher.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/1.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSString+YNMatcher.h"

@implementation NSString (YNMatcher)

- (NSArray *)yn_matchWithRegex:(NSString *)regex
{
    NSTextCheckingResult *result = [self yn_firstMatchedResultWithRegex:regex];
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:[result numberOfRanges]];
    for (int i = 0 ; i < [result numberOfRanges]; i ++ ) {
        [mArray addObject:[self substringWithRange:[result rangeAtIndex:i]]];
    }
    return mArray;
}


- (NSString *)yn_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index
{
    NSTextCheckingResult *result = [self yn_firstMatchedResultWithRegex:regex];
    return [self substringWithRange:[result rangeAtIndex:index]];
}


- (NSString *)yn_firstMatchedGroupWithRegex:(NSString *)regex
{
    NSTextCheckingResult *result = [self yn_firstMatchedResultWithRegex:regex];
    return [self substringWithRange:[result rangeAtIndex:1]];
}


- (NSTextCheckingResult *)yn_firstMatchedResultWithRegex:(NSString *)regex
{
    NSRegularExpression *regexExpression = [NSRegularExpression regularExpressionWithPattern:regex options:(NSRegularExpressionOptions)0 error:NULL];
    NSRange range = {0, self.length};
    return [regexExpression firstMatchInString:self options:(NSMatchingOptions)0 range:range];
}


@end
