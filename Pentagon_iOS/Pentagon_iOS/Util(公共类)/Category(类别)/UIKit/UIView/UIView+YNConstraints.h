//
//  UIView+ynConstraints.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YNConstraints)
- (NSLayoutConstraint *)yn_constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)yn_leftConstraint;
- (NSLayoutConstraint *)yn_rightConstraint;
- (NSLayoutConstraint *)yn_topConstraint;
- (NSLayoutConstraint *)yn_bottomConstraint;
- (NSLayoutConstraint *)yn_leadingConstraint;
- (NSLayoutConstraint *)yn_trailingConstraint;
- (NSLayoutConstraint *)yn_widthConstraint;
- (NSLayoutConstraint *)yn_heightConstraint;
- (NSLayoutConstraint *)yn_centerXConstraint;
- (NSLayoutConstraint *)yn_centerYConstraint;
- (NSLayoutConstraint *)yn_baseLineConstraint;
@end
