//
//  NSData+YNHash.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YNHash)
/**
 *  @brief  md5 NSData
 */
@property (readonly) NSData *yn_md5Data;
/**
 *  @brief  sha1Data NSData
 */
@property (readonly) NSData *yn_sha1Data;
/**
 *  @brief  sha256Data NSData
 */
@property (readonly) NSData *yn_sha256Data;
/**
 *  @brief  sha512Data NSData
 */
@property (readonly) NSData *yn_sha512Data;

/**
 *  @brief  md5 NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yn_hmacMD5DataWithKey:(NSData *)key;
/**
 *  @brief  sha1Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yn_hmacSHA1DataWithKey:(NSData *)key;
/**
 *  @brief  sha256Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yn_hmacSHA256DataWithKey:(NSData *)key;
/**
 *  @brief  sha512Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)yn_hmacSHA512DataWithKey:(NSData *)key;


@end
