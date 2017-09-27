//
//  PTButton.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTButton.h"

@implementation PTButton

- (void)drawRect:(CGRect)rect{
    [self yn_setBackgroundColor:k_Color_Normal forState:UIControlStateNormal];
    [self yn_setBackgroundColor:k_Color_HighLighted forState:UIControlStateHighlighted];
    [self yn_setBackgroundColor:k_Color_Disable forState:UIControlStateDisabled];
    
    [self setTitleColor:k_Color_Title forState:UIControlStateNormal];
    [self setTitleColor:k_Color_Title forState:UIControlStateHighlighted];
    [self setTitleColor:k_Color_Title forState:UIControlStateDisabled];

}

@end
