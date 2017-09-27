//
//  NSObject+YNBlocks.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YNBlocks)

+ (id)yn_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
+ (id)yn_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
- (id)yn_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)yn_performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay;
+ (void)yn_cancelBlock:(id)block;
+ (void)yn_cancelPreviousPerformBlock:(id)aWrappingBlockHandle __attribute__ ((deprecated));

@end
