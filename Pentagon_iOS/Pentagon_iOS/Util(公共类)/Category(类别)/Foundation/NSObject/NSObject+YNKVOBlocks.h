//
//  NSObject+YNKVOBlocks.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/7.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^YNKVOBlock)(NSDictionary *change, void *context);

@interface NSObject (YNKVOBlocks)

- (void)yn_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context
             withBlock:(YNKVOBlock)block;

-(void)yn_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath;

-(void)yn_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(YNKVOBlock)block;

-(void)yn_removeBlockObserverForKeyPath:(NSString *)keyPath;


@end
