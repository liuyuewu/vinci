//
//  NSString+YNHash.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YNHash)

@property (readonly) NSString *yn_md5String;
@property (readonly) NSString *yn_sha1String;
@property (readonly) NSString *yn_sha256String;
@property (readonly) NSString *yn_sha512String;

- (NSString *)yn_hmacMD5StringWithKey:(NSString *)key;
- (NSString *)yn_hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)yn_hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)yn_hmacSHA512StringWithKey:(NSString *)key;

@end
