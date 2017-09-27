//
//  UITextField+Blocks.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (YNBlocks)
@property (copy, nonatomic) BOOL (^yn_shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^yn_shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^yn_didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^yn_didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^yn_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^yn_shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^yn_shouldClearBlock)(UITextField *textField);

- (void)setYn_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)setYn_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setYn_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setYn_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setYn_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setYn_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setYn_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
@end
