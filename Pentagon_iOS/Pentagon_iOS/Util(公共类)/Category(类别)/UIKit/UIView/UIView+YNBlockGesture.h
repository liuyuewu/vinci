//
//  UIView+UIView_BlockGesture.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YNGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (YNBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)yn_addTapActionWithBlock:(YNGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)yn_addLongPressActionWithBlock:(YNGestureActionBlock)block;
@end
