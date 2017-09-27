//
//  UIViewController+BackButtonTouched.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIViewController+YNBackButtonTouched.h"
#import <objc/runtime.h>
static const void *YNBackButtonHandlerKey = &YNBackButtonHandlerKey;

@implementation UIViewController (YNBackButtonTouched)
-(void)yn_backButtonTouched:(YNBackButtonHandler)backButtonHandler{
    objc_setAssociatedObject(self, YNBackButtonHandlerKey, backButtonHandler, OBJC_ASSOCIATION_COPY);
}
- (YNBackButtonHandler)yn_backButtonTouched
{
    return objc_getAssociatedObject(self, YNBackButtonHandlerKey);
}
@end

@implementation UINavigationController (ShouldPopItem)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

   	UIViewController* vc = [self topViewController];
    YNBackButtonHandler handler = [vc yn_backButtonTouched];
    if (handler) {
        // Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906

        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }

	return NO;
}
@end
