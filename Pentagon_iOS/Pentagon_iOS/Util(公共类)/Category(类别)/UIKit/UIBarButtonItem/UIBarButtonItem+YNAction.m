//
//  UIBarButtonItem+ynAction.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

char * const UIBarButtonItemYNActionBlock = "UIBarButtonItemYNActionBlock";
#import "UIBarButtonItem+YNAction.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (ynAction)

- (void)yn_performActionBlock {
    
    dispatch_block_t block = self.yn_actionBlock;
    
    if (block)
        block();
    
}

- (BarButtonYNActionBlock)yn_actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemYNActionBlock);
}

- (void)setYn_actionBlock:(BarButtonYNActionBlock)actionBlock
 {
    
    if (actionBlock != self.yn_actionBlock) {
        [self willChangeValueForKey:@"yn_actionBlock"];
        
        objc_setAssociatedObject(self,
                                 UIBarButtonItemYNActionBlock,
                                 actionBlock,
                                 OBJC_ASSOCIATION_COPY);
        
        // Sets up the action.
        [self setTarget:self];
        [self setAction:@selector(yn_performActionBlock)];
        
        [self didChangeValueForKey:@"yn_actionBlock"];
    }
}
@end
