//
//  NSArray+YNBlock.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YNBlock)

- (void)yn_each:(void (^)(id object))block;
- (void)yn_eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)yn_map:(id (^)(id object))block;
- (NSArray *)yn_filter:(BOOL (^)(id object))block;
- (NSArray *)yn_reject:(BOOL (^)(id object))block;
- (id)yn_detect:(BOOL (^)(id object))block;
- (id)yn_reduce:(id (^)(id accumulator, id object))block;
- (id)yn_reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;

@end
