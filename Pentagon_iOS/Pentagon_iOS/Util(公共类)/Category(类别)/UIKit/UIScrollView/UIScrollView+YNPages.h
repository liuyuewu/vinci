//
//  UIScrollView+ynPages.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YNPages)
- (NSInteger)yn_pages;
- (NSInteger)yn_currentPage;
- (CGFloat)yn_scrollPercent;

- (CGFloat)yn_pagesY;
- (CGFloat)yn_pagesX;
- (CGFloat)yn_currentPageY;
- (CGFloat)yn_currentPageX;
- (void)yn_setPageY:(CGFloat)page;
- (void)yn_setPageX:(CGFloat)page;
- (void)yn_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void)yn_setPageX:(CGFloat)page animated:(BOOL)animated;
@end
