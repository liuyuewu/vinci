//
//  NSString+YNContains.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YNContains)

/**
 *  @brief 是否包含字母
 */
- (BOOL)yn_isContainsOnlyLetters;
/**
 *  @brief 是否包含数字
 */
- (BOOL)yn_isContainsOnlyNumbers;
/**
 *  @brief 是否包含字母和数字
 */
- (BOOL)yn_isContainsOnlyNumbersAndLetters;

/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)yn_isContainChinese;
/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)yn_isContainBlank;

- (BOOL)yn_containsCharacterSet:(NSCharacterSet *)set;
/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)yn_containsaString:(NSString *)string;
/**
 *  @brief 获取字符数量
 */
- (int)yn_wordsCount;

/**
 *  @brief 字符串单词数量
 */
- (NSUInteger)yn_countOfWordString;


/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)yn_makeUnicodeToString;



@end
