//
//  UIScrollView+ynAddition.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIScrollView+YNAddition.h"

@implementation UIScrollView (YNAddition)
//frame
- (CGFloat)yn_contentWidth {
    return self.contentSize.width;
}
- (void)setYn_contentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)yn_contentHeight {
    return self.contentSize.height;
}
- (void)setYn_contentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)yn_contentOffsetX {
    return self.contentOffset.x;
}
- (void)setYn_contentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)yn_contentOffsetY {
    return self.contentOffset.y;
}
- (void)setYn_contentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}
//


- (CGPoint)yn_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)yn_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)yn_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)yn_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}
- (YNScrollDirection)yn_ScrollDirection
{
    YNScrollDirection direction;
    
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f)
    {
        direction = YNScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f)
    {
        direction = YNScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f)
    {
        direction = YNScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f)
    {
        direction = YNScrollDirectionRight;
    }
    else
    {
        direction = YNScrollDirectionWTF;
    }
    
    return direction;
}
- (BOOL)yn_isScrolledToTop
{
    return self.contentOffset.y <= [self yn_topContentOffset].y;
}
- (BOOL)yn_isScrolledToBottom
{
    return self.contentOffset.y >= [self yn_bottomContentOffset].y;
}
- (BOOL)yn_isScrolledToLeft
{
    return self.contentOffset.x <= [self yn_leftContentOffset].x;
}
- (BOOL)yn_isScrolledToRight
{
    return self.contentOffset.x >= [self yn_rightContentOffset].x;
}
- (void)yn_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self yn_topContentOffset] animated:animated];
}
- (void)yn_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self yn_bottomContentOffset] animated:animated];
}
- (void)yn_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self yn_leftContentOffset] animated:animated];
}
- (void)yn_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self yn_rightContentOffset] animated:animated];
}
- (NSUInteger)yn_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)yn_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}
- (void)yn_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)yn_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}


@end
