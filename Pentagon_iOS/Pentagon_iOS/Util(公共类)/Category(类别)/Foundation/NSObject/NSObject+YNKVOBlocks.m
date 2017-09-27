//
//  NSObject+YNKVOBlocks.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/7.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSObject+YNKVOBlocks.h"
#import <objc/runtime.h>

@implementation NSObject (YNKVOBlocks)

-(void)yn_addObserver:(NSObject *)observer
           forKeyPath:(NSString *)keyPath
              options:(NSKeyValueObservingOptions)options
              context:(void *)context
            withBlock:(YNKVOBlock)block {
    
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

-(void)yn_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}

-(void)yn_observeValueForKeyPath:(NSString *)keyPath
                        ofObject:(id)object
                          change:(NSDictionary *)change
                         context:(void *)context {
    
    YNKVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    block(change, context);
}

-(void)yn_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(YNKVOBlock)block {
    
    [self yn_addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}

-(void)yn_removeBlockObserverForKeyPath:(NSString *)keyPath {
    [self yn_removeBlockObserver:self forKeyPath:keyPath];
}


@end
