//
//  UITextView+Select.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (YNSelect)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)yn_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)yn_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)yn_setSelectedRange:(NSRange)range;



//https://github.com/pclion/TextViewCalculateLength
// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
- (NSInteger)yn_getInputLengthWithText:(NSString *)text;
/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger textLength = [textView getInputLengthWithText:text];
    if (textLength > 20) {
        //超过20个字可以删除
        if ([text isEqualToString:@""]) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView getInputLengthWithText:nil] > 20) {
        textView.text = [textView.text substringToIndex:20];
    }
}
*/

@end
