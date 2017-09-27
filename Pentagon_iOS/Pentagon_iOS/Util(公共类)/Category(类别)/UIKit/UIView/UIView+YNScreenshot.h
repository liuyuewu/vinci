//
//  UIView+Screenshot.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/1/10.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YNScreenshot)
/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)yn_screenshot;

/**
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @return 截图
 */
- (UIImage *)yn_screenshot:(CGFloat)maxWidth;
@end
