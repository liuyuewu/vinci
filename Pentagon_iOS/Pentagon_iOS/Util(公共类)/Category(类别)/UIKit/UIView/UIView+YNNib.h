//
//  UIView+Nib.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (YNNib)
+ (UINib *)yn_loadNib;
+ (UINib *)yn_loadNibNamed:(NSString*)nibName;
+ (UINib *)yn_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)yn_loadInstanceFromNib;
+ (instancetype)yn_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)yn_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)yn_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

@end
