//
//  NSString+YNScore.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, NSStringYNScoreOption) {
    NSStringYNScoreOptionNone = 1 << 0,
    NSStringYNScoreOptionFavorSmallerWords = 1 << 1,
    NSStringYNScoreOptionReducedLongStringPenalty = 1 << 2
};

@interface NSString (YNScore)

//模糊匹配字符串 查找某两个字符串的相似程度
- (CGFloat)yn_scoreAgainst:(NSString *)otherString;
- (CGFloat)yn_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;
- (CGFloat)yn_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(NSStringYNScoreOption)options;


@end
