//
//  UIControl+ynActionBlocks.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/lavoy/ALActionBlocks

#import <UIKit/UIKit.h>
typedef void (^UIControlYNActionBlock)(id weakSender);


@interface UIControlYNActionBlockWrapper : NSObject
@property (nonatomic, copy) UIControlYNActionBlock yn_actionBlock;
@property (nonatomic, assign) UIControlEvents yn_controlEvents;
- (void)yn_invokeBlock:(id)sender;
@end



@interface UIControl (YNActionBlocks)
- (void)yn_handleControlEvents:(UIControlEvents)controlEvents withBlock:(UIControlYNActionBlock)actionBlock;
- (void)yn_removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;
@end
