//
//  UIScreen+ynFrame.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (YNFrame)
+ (CGSize)yn_size;
+ (CGFloat)yn_width;
+ (CGFloat)yn_height;

+ (CGSize)yn_orientationSize;
+ (CGFloat)yn_orientationWidth;
+ (CGFloat)yn_orientationHeight;
+ (CGSize)yn_DPISize;

@end
