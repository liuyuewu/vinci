//
//  NSString+WJM.h
//  OCCategorie
//
//  Created by WJM on 15/11/23.
//  Copyright © 2015年 WJM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WJM)

/**
 * MD5加密
 */
-(NSString *)MD5;
/**
 * sha1加密
 */
-(NSString *)sha1;
/**
 * 字符串倒序
 */
-(NSString *)reverse;
/**
 * 16进制编码
 */
-(NSString *)URLEncode;
/**
 * 16进制解码
 */
-(NSString *)URLDecode;
/**
 * 字符串去掉所有空格
 */
-(NSString *)stringByStrippingWhitespace;
/**
 *  检查字符串 是否 为空  YES/NO
 */
-(BOOL)isValid;
/**
 *  删除空白字符串
 */
- (NSString *)removeWhiteSpacesFromString;

/**
 *   字符串的 单词数量
 */
- (NSUInteger)countNumberOfWords;
/**
 *  字符串是否包含子字符串
 */
- (BOOL)containsString:(NSString *)subString;
/**
 * 字符串是否以某个字符串为开始
 */
- (BOOL)isBeginsWith:(NSString *)string;
/**
 *  字符串是否以某个字符串为结束
 */
- (BOOL)isEndssWith:(NSString *)string;
/**
 *  字符串替换
 *
 *  @param olderChar 老字符串
 *  @param newerChar 新字符串
 *
 *  @return 替换后的字符串
 */
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
/**
 *  获取位置1和位置2之间的字符串
 *
 *  @param begin 开始位置
 *  @param end   结束位置
 *
 *  @return 获取的字符串
 */
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
/**
 *  拼接字符串
*/
- (NSString *)addString:(NSString *)string;
/**
 *  删除字符串
 */
- (NSString *)removeSubString:(NSString *)subString;
/**
 *  是否包含字母
 */
- (BOOL)containsOnlyLetters;
/**
 *  是否包含数字
 */
- (BOOL)containsOnlyNumbers;
/**
 *  是否包含字母和数字
 */
- (BOOL)containsOnlyNumbersAndLetters;
/**
 *  该字符串是否在数组中
 */
- (BOOL)isInThisarray:(NSArray*)array;
/**
 *  把数组 转化为 字符串  元素之间以空格间隔
 */
+ (NSString *)getStringFromArray:(NSArray *)array;
/**
 * 把字符串转化为数组
 */
- (NSArray *)getArray;
/**
 *  获取版本号
 *
 *  @return 返回版本号
 */
+ (NSString *)getMyApplicationVersion;
/**
 *  获取App 名称
 *
 *  @return 返回App名称
 */
+ (NSString *)getMyApplicationName;
/**
 *  把字符串 转化为 NSData
 */
- (NSData *)convertToData;
/**
 *  把NSData 转化为 字符串
 */
+ (NSString *)getStringFromData:(NSData *)data;
/**
 *  是否是邮箱
 */
- (BOOL)isValidEmail;
/**
 *  是否是电话号码
 */
- (BOOL)isVAlidPhoneNumber;
/**
 *  电话号码隐藏显示
 */
- (NSString *)hidePhoneNumber;

/**
 * 银行卡号隐藏
 */
- (NSString *)hideBankNumber;

/**
 *  是否是网址
 */
- (BOOL)isValidUrl;

- (NSString*) removeLastOneChar:(NSString*)origin;

- (NSMutableArray *)positionsOfTheCharactersInString:(NSString *)basisString andSubClassString:(NSString *)subClassString;

@end
