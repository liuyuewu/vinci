//
//  UIView+CustomBorder.h
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//
/**
 * 视图添加边框
 */

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, YNExcludePoint) {
    YNExcludeStartPoint = 1 << 0,
    YNExcludeEndPoint = 1 << 1,
    YNExcludeAllPoint = ~0UL
};


@interface UIView (YNCustomBorder)

- (void)yn_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)yn_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth;
- (void)yn_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;
- (void)yn_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth;

- (void)yn_removeTopBorder;
- (void)yn_removeLeftBorder;
- (void)yn_removeBottomBorder;
- (void)yn_removeRightBorder;


- (void)yn_addTopBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(YNExcludePoint)edge;
- (void)yn_addLeftBorderWithColor: (UIColor *) color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(YNExcludePoint)edge;
- (void)yn_addBottomBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(YNExcludePoint)edge;
- (void)yn_addRightBorderWithColor:(UIColor *)color width:(CGFloat) borderWidth excludePoint:(CGFloat)point edgeType:(YNExcludePoint)edge;
@end
