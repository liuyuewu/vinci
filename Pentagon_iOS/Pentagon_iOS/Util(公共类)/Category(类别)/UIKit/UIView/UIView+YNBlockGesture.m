//
//  UIView+UIView_BlockGesture.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+YNBlockGesture.h"
#import <objc/runtime.h>
static char yn_kActionHandlerTapBlockKey;
static char yn_kActionHandlerTapGestureKey;
static char yn_kActionHandlerLongPressBlockKey;
static char yn_kActionHandlerLongPressGestureKey;

@implementation UIView (YNBlockGesture)
- (void)yn_addTapActionWithBlock:(YNGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &yn_kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yn_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &yn_kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &yn_kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)yn_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        YNGestureActionBlock block = objc_getAssociatedObject(self, &yn_kActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
- (void)yn_addLongPressActionWithBlock:(YNGestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &yn_kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(yn_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &yn_kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &yn_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)yn_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        YNGestureActionBlock block = objc_getAssociatedObject(self, &yn_kActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
@end
