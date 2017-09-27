//
//  NSDictionary+YNMerge.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YNMerge)

/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)yn_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)yn_dictionaryByMergingWith:(NSDictionary *)dict;

#pragma mark - Manipulation
- (NSDictionary *)yn_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)yn_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;


@end
