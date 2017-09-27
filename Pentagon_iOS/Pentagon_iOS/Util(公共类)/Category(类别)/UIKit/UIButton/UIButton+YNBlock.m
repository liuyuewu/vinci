//
//  UIButton+Block.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIButton+YNBlock.h"
#import <objc/runtime.h>
static const void *yn_UIButtonBlockKey = &yn_UIButtonBlockKey;

@implementation UIButton (yn_Block)
-(void)yn_addActionHandler:(YNTouchedButtonBlock)touchHandler{
    objc_setAssociatedObject(self, yn_UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(yn_blockActionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)yn_blockActionTouched:(UIButton *)btn{
    YNTouchedButtonBlock block = objc_getAssociatedObject(self, yn_UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end

