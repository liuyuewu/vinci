//
//  UILabel+YNAttributeText.h
//  Panda
//
//  Created by 王阳 on 2017/3/31.
//  Copyright © 2017年 王阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YNAttributeText)

- (NSMutableAttributedString *)setText:(NSString *)text withFont:(UIFont *)font withRange:(NSRange)range;
- (NSMutableAttributedString *)setText:(NSString *)text withColor:(UIColor *)color withRange:(NSRange)range;

- (NSMutableAttributedString *)setText:(NSString *)text withColor:(UIColor *)color withFont:(UIFont *)font withRange:(NSRange)range;

- (NSMutableAttributedString *)setText:(NSString *)text withParagraphHeight:(CGFloat)paragraphHeight withKernAttributeHeight:(CGFloat)kernHeight;

@end
