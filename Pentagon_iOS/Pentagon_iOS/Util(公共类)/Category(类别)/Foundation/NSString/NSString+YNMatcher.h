//
//  NSString+YNMatcher.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/1.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YNMatcher)

- (NSArray *)yn_matchWithRegex:(NSString *)regex;
- (NSString *)yn_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;
- (NSString *)yn_firstMatchedGroupWithRegex:(NSString *)regex;
- (NSTextCheckingResult *)yn_firstMatchedResultWithRegex:(NSString *)regex;

@end
