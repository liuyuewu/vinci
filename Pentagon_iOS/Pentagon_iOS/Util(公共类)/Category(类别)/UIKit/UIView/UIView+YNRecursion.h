//
//  UIView+Recursion.h
//  ynCategories
//
//  Created by Jakey on 15/6/23.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YNSubviewBlock) (UIView* view);
typedef void (^YNSuperviewBlock) (UIView* superview);
@interface UIView (YNRecursion)

/**
 *  @brief  寻找子视图
 *
 *  @param recurse 回调
 *
 *  @return  Return YES from the block to recurse into the subview.
 Set stop to YES to return the subview.
 */
- (UIView*)yn_findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;


-(void)yn_runBlockOnAllSubviews:(YNSubviewBlock)block;
-(void)yn_runBlockOnAllSuperviews:(YNSuperviewBlock)block;
-(void)yn_enableAllControlsInViewHierarchy;
-(void)yn_disableAllControlsInViewHierarchy;
@end
