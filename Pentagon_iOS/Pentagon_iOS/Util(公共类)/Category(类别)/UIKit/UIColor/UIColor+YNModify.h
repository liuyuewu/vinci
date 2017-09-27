//
//  UIColor+Modify.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/1/2.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YNModify)
- (UIColor *)yn_invertedColor;
- (UIColor *)yn_colorForTranslucency;
- (UIColor *)yn_lightenColor:(CGFloat)lighten;
- (UIColor *)yn_darkenColor:(CGFloat)darken;
@end
