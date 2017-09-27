//
//  UIViewController+BackButtonTouched.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^YNBackButtonHandler)(UIViewController *vc);
@interface UIViewController (YNBackButtonTouched)
/**
 *  @author ynCategories
 *
 *  navgation 返回按钮回调
 *
 *  @param backButtonHandler <#backButtonHandler description#>
 */
-(void)yn_backButtonTouched:(YNBackButtonHandler)backButtonHandler;
@end
