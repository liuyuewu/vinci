//
//  NSString+WJM.m
//  OCCategorie
//
//  Created by WJM on 15/11/23.
//  Copyright © 2015年 WJM. All rights reserved.
//

#import "NSString+WJM.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WJM)

//MD5加密
- (NSString *)MD5 {
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}
//sha1加密
-(NSString *)sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data 	 = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)(data.length), digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
//字符串倒叙
-(NSString *)reverse {
    NSInteger length = [self length];
    unichar *buffer = calloc(length, sizeof(unichar));
    
    // TODO(gabe): Apparently getCharacters: is really slow
    [self getCharacters:buffer range:NSMakeRange(0, length)];
    
    for(int i = 0, mid = ceil(length/2.0); i < mid; i++) {
        unichar c = buffer[i];
        buffer[i] = buffer[length-i-1];
        buffer[length-i-1] = c;
    }
    
    NSString *s = [[NSString alloc] initWithCharacters:buffer length:length];
    buffer = nil;
    return s;
}
//字符串去空格
-(NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//编码
-(NSString *)URLEncode {
    
    
//    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                  (__bridge CFStringRef)self,
//                                                                  NULL,
//                                                                  CFSTR(":/?#[]@!$&'()*+,;="),
//                                                                  kCFStringEncodingUTF8);
//    return [NSString stringWithString:(__bridge_transfer NSString *)encoded];
    return nil;
}
//解码
-(NSString *)URLDecode {
    
    CFStringRef decoded = CFURLCreateStringByReplacingPercentEscapes( kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)self,
                                                                     CFSTR(":/?#[]@!$&'()*+,;=") );
    return [NSString stringWithString:(__bridge_transfer NSString *)decoded];
}
//检查字符串 是否 为空  YES/NO
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO :YES;
}

// 删除空白字符串
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

// 字符串的 单词数量
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    
    return count;
}

// 字符串是否包含子字符串
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// 字符串以某个字符串为开始
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// 字符串是否以某个字符串为结束
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}

// 字符串替换
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// 获取位置1和位置2之间的字符串
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// 拼接字符串
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

// 删除字符串
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}


// 字符串中 是否包含字母
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// 字符串中 是否包含数字
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// 是否包含字母和数字
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// 该字符串是否 在此数组中
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// 数组转字符串 以 空格 为间隔
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@" "];
}

// 字符串转数组
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// 获取版本号
+ (NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    return version;
}

// 获取App名称
+ (NSString *)getMyApplicationName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    return name;
}
// 字符串转NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
// NSData转字符串
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}
// 是否是邮箱
- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// 是否是电话号码
- (BOOL)isVAlidPhoneNumber
{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189,181(增加)
//     */
//    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189,181(增加)
//     22         */
//    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:self]
//         || [regextestcm evaluateWithObject:self]
//         || [regextestct evaluateWithObject:self]
//         || [regextestcu evaluateWithObject:self])) {
//        return YES;
//    }
//
    
    return self.length == 11 ? YES:NO;
}

/**
 *  电话号码隐藏显示
 */
- (NSString *)hidePhoneNumber{
    NSRange range = NSMakeRange(3, 4);
    NSString *hideString = [self stringByReplacingCharactersInRange:range withString:@"*****"];
    return hideString;
}

- (NSString *)hideBankNumber{
    NSRange range = NSMakeRange(0, self.length - 4);
    NSString *hideString = [self stringByReplacingCharactersInRange:range withString:@"*********"];
    return hideString;
}

// 是否是网址
- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}
- (NSString*) removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}

- (NSMutableArray *)positionsOfTheCharactersInString:(NSString *)basisString andSubClassString:(NSString *)subClassString
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSMutableString *str = [NSMutableString  stringWithString:basisString];
    
    for (int i=0; i<basisString.length; i++) {
        
        NSRange range =[str rangeOfString:subClassString];
        
        if (range.location!=NSNotFound) {
            
            //range.location(子串起始位置)
            //range.length(子串长度)
            str = (NSMutableString *)[str substringFromIndex:range.location+range.length];//截取范围类的字符串
            [array addObject:[NSString stringWithFormat:@"%lu",range.location]];
        }else{
            NSLog(@"没有子串");
        }
    }
    
    return array;
}

@end
