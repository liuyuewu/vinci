//
//  NSSet+Block.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (YNBlock)
- (void)yn_each:(void (^)(id))block;
- (void)yn_eachWithIndex:(void (^)(id, int))block;
- (NSArray *)yn_map:(id (^)(id object))block;
- (NSArray *)yn_select:(BOOL (^)(id object))block;
- (NSArray *)yn_reject:(BOOL (^)(id object))block;
- (NSArray *)yn_sort;
- (id)yn_reduce:(id(^)(id accumulator, id object))block;
- (id)yn_reduce:(id)initial withBlock:(id(^)(id accumulator, id object))block;
@end
