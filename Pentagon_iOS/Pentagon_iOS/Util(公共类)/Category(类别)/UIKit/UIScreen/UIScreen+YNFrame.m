//
//  UIScreen+ynFrame.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIScreen+YNFrame.h"

@implementation UIScreen (YNFrame)
+ (CGSize)yn_size
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)yn_width
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)yn_height
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGSize)yn_orientationSize
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion]
                             doubleValue];
    BOOL isLand =   UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    return (systemVersion>8.0 && isLand) ? yn_SizeSWAP([UIScreen yn_size]) : [UIScreen yn_size];
}

+ (CGFloat)yn_orientationWidth
{
    return [UIScreen yn_orientationSize].width;
}

+ (CGFloat)yn_orientationHeight
{
    return [UIScreen yn_orientationSize].height;
}

+ (CGSize)yn_DPISize
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return CGSizeMake(size.width * scale, size.height * scale);
}


/**
 *  交换高度与宽度
 */
static inline CGSize yn_SizeSWAP(CGSize size) {
    return CGSizeMake(size.height, size.width);
}
@end
