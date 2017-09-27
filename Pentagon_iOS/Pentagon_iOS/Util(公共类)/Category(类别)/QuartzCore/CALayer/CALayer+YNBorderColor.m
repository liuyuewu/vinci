//
//  CALayer+ynBorderColor.m
//  test
//
//  Created by LiuLogan on 15/6/17.
//  Copyright (c) 2015年 Xidibuy. All rights reserved.
//

#import "CALayer+YNBorderColor.h"

@implementation CALayer (ynBorderColor)

-(void)setyn_borderColor:(UIColor *)yn_borderColor{
    self.borderColor = yn_borderColor.CGColor;
}

- (UIColor*)yn_borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
