//
//  UIView+Nib.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIView+ynNib.h"

@implementation UIView (YNNib)
#pragma mark - Nibs
+ (UINib *)yn_loadNib
{
    return [self yn_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)yn_loadNibNamed:(NSString*)nibName
{
    return [self yn_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)yn_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)yn_loadInstanceFromNib
{
    return [self yn_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)yn_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self yn_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)yn_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self yn_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)yn_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end
