//
//  NSDictionary+YNBlock.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YNBlock)

#pragma mark - RX
- (void)yn_each:(void (^)(id k, id v))block;
- (void)yn_eachKey:(void (^)(id k))block;
- (void)yn_eachValue:(void (^)(id v))block;
- (NSArray *)yn_map:(id (^)(id key, id value))block;
- (NSDictionary *)yn_pick:(NSArray *)keys;
- (NSDictionary *)yn_omit:(NSArray *)key;

@end
