//
//  UIScrollView+ynAddition.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YNScrollDirection) {
    YNScrollDirectionUp,
    YNScrollDirectionDown,
    YNScrollDirectionLeft,
    YNScrollDirectionRight,
    YNScrollDirectionWTF
};

@interface UIScrollView (YNAddition)
@property(nonatomic) CGFloat yn_contentWidth;
@property(nonatomic) CGFloat yn_contentHeight;
@property(nonatomic) CGFloat yn_contentOffsetX;
@property(nonatomic) CGFloat yn_contentOffsetY;

- (CGPoint)yn_topContentOffset;
- (CGPoint)yn_bottomContentOffset;
- (CGPoint)yn_leftContentOffset;
- (CGPoint)yn_rightContentOffset;

- (YNScrollDirection)yn_ScrollDirection;

- (BOOL)yn_isScrolledToTop;
- (BOOL)yn_isScrolledToBottom;
- (BOOL)yn_isScrolledToLeft;
- (BOOL)yn_isScrolledToRight;
- (void)yn_scrollToTopAnimated:(BOOL)animated;
- (void)yn_scrollToBottomAnimated:(BOOL)animated;
- (void)yn_scrollToLeftAnimated:(BOOL)animated;
- (void)yn_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)yn_verticalPageIndex;
- (NSUInteger)yn_horizontalPageIndex;

- (void)yn_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)yn_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
@end
