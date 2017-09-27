//
//  NSData+YNDataCache.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/5.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSData+YNDataCache.h"
#import <CommonCrypto/CommonDigest.h>

#define kSDMaxCacheFileAmount 100
@implementation NSData (YNDataCache)

+ (NSString *)yn_cachePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Caches"];
    path = [path stringByAppendingPathComponent:@"ynDataCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)yn_creatMD5StringWithString:(NSString *)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    [hash lowercaseString];
    return hash;
}

+ (NSString *)yn_creatDataPathWithString:(NSString *)string
{
    NSString *path = [NSData yn_cachePath];
    path = [path stringByAppendingPathComponent:[self yn_creatMD5StringWithString:string]];
    return path;
}

- (void)yn_saveDataCacheWithIdentifier:(NSString *)identifier
{
    NSString *path = [NSData yn_creatDataPathWithString:identifier];
    [self writeToFile:path atomically:YES];
}

+ (NSData *)yn_getDataCacheWithIdentifier:(NSString *)identifier
{
    static BOOL isCheckedCacheDisk = NO;
    if (!isCheckedCacheDisk) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [manager contentsOfDirectoryAtPath:[self yn_cachePath] error:nil];
        if (contents.count >= kSDMaxCacheFileAmount) {
            [manager removeItemAtPath:[self yn_cachePath] error:nil];
        }
        isCheckedCacheDisk = YES;
    }
    NSString *path = [self yn_creatDataPathWithString:identifier];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}



@end
