//
//  UILabel+YNAttributeText.m
//  Panda
//
//  Created by 王阳 on 2017/3/31.
//  Copyright © 2017年 王阳. All rights reserved.
//

#import "UILabel+YNAttributeText.h"

@implementation UILabel (YNAttributeText)

- (NSMutableAttributedString *)setText:(NSString *)text withFont:(UIFont *)font withRange:(NSRange)range{
    NSMutableAttributedString *attribuStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attribuStr addAttributes:@{NSFontAttributeName : font} range:range];
    return attribuStr;
}

- (NSMutableAttributedString *)setText:(NSString *)text withColor:(UIColor *)color withRange:(NSRange)range{
    NSMutableAttributedString *attribuStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attribuStr addAttributes:@{NSForegroundColorAttributeName : color} range:range];
    return attribuStr;
}

- (NSMutableAttributedString *)setText:(NSString *)text withColor:(UIColor *)color withFont:(UIFont *)font withRange:(NSRange)range{
    NSMutableAttributedString *attribuStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attribuStr addAttributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : font} range:range];
    return attribuStr;
}

- (NSMutableAttributedString *)setText:(NSString *)text withParagraphHeight:(CGFloat)paragraphHeight withKernAttributeHeight:(CGFloat)kernHeight{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = paragraphHeight; // 调整行间距
    NSRange range = NSMakeRange(0, [text length]);
    
    [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kernHeight)} range:range];
    return attributedString;
}




@end
