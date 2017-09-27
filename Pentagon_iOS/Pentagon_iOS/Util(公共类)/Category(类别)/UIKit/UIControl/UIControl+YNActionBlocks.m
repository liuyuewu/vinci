//
//  UIControl+ynActionBlocks.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIControl+YNActionBlocks.h"
#import <objc/runtime.h>

static const void *UIControlynActionBlockArray = &UIControlynActionBlockArray;

@implementation UIControlYNActionBlockWrapper

- (void)yn_invokeBlock:(id)sender {
    if (self.yn_actionBlock) {
        self.yn_actionBlock(sender);
    }
}
@end


@implementation UIControl (ynActionBlocks)
-(void)yn_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlYNActionBlock)actionBlock {
    NSMutableArray *actionBlocksArray = [self yn_actionBlocksArray];
    
    UIControlYNActionBlockWrapper *blockActionWrapper = [[UIControlYNActionBlockWrapper alloc] init];
    blockActionWrapper.yn_actionBlock = actionBlock;
    blockActionWrapper.yn_controlEvents = controlEvents;
    [actionBlocksArray addObject:blockActionWrapper];
    
    [self addTarget:blockActionWrapper action:@selector(yn_invokeBlock:) forControlEvents:controlEvents];
}


- (void)yn_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents {
    NSMutableArray *actionBlocksArray = [self yn_actionBlocksArray];
    NSMutableArray *wrappersToRemove = [NSMutableArray arrayWithCapacity:[actionBlocksArray count]];
    
    [actionBlocksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlYNActionBlockWrapper *wrapperTmp = obj;
        if (wrapperTmp.yn_controlEvents == controlEvents) {
            [wrappersToRemove addObject:wrapperTmp];
            [self removeTarget:wrapperTmp action:@selector(yn_invokeBlock:) forControlEvents:controlEvents];
        }
    }];
    
    [actionBlocksArray removeObjectsInArray:wrappersToRemove];
}


- (NSMutableArray *)yn_actionBlocksArray {
    NSMutableArray *actionBlocksArray = objc_getAssociatedObject(self, UIControlynActionBlockArray);
    if (!actionBlocksArray) {
        actionBlocksArray = [NSMutableArray array];
        objc_setAssociatedObject(self, UIControlynActionBlockArray, actionBlocksArray, OBJC_ASSOCIATION_RETAIN);
    }
    return actionBlocksArray;
}
@end
