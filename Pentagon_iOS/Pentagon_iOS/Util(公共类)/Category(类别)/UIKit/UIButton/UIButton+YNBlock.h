//
//  UIButton+Block.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YNTouchedButtonBlock)(NSInteger tag);

@interface UIButton (YNBlock)
-(void)yn_addActionHandler:(YNTouchedButtonBlock)touchHandler;
@end
