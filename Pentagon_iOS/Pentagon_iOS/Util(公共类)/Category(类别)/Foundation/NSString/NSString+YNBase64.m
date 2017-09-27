//
//  NSString+YNBase64.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSString+YNBase64.h"
#import "NSData+YNBase64.h"

@implementation NSString (YNBase64)

+ (NSString *)yn_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData yn_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
- (NSString *)yn_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data yn_base64EncodedStringWithWrapWidth:wrapWidth];
}
- (NSString *)yn_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data yn_base64EncodedString];
}
- (NSString *)yn_base64DecodedString
{
    return [NSString yn_stringWithBase64EncodedString:self];
}
- (NSData *)yn_base64DecodedData
{
    return [NSData yn_dataWithBase64EncodedString:self];
}
@end
