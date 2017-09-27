//
//  NSString+YNBase64.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YNBase64)

+ (NSString *)yn_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)yn_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)yn_base64EncodedString;
- (NSString *)yn_base64DecodedString;
- (NSData *)yn_base64DecodedData;

@end
