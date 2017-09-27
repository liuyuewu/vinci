//
//  NSData+YNGzip.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/5.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YNGzip)

/**
 *  @brief  GZIP压缩
 *
 *  @param level 压缩级别
 *
 *  @return 压缩后的数据
 */
- (NSData *)yn_gzippedDataWithCompressionLevel:(float)level;

/**
 *  @brief  GZIP压缩 压缩级别 默认-1
 *
 *  @return 压缩后的数据
 */
- (NSData *)yn_gzippedData;

/**
 *  @brief  GZIP解压
 *
 *  @return 解压后数据
 */
- (NSData *)yn_gunzippedData;

- (BOOL)yn_isGzippedData;


@end
