//
//  NSData+YNDataCache.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/5.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YNDataCache)

/**
 *  将URL作为key保存到磁盘里缓存起来
 *
 *  @param identifier url.absoluteString
 */
- (void)yn_saveDataCacheWithIdentifier:(NSString *)identifier;

/**
 *  取出缓存data
 *
 *  @param identifier url.absoluteString
 *
 *  @return 缓存
 */
+ (NSData *)yn_getDataCacheWithIdentifier:(NSString *)identifier;


@end
