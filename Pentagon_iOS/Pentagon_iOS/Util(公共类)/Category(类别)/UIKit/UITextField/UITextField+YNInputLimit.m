//
//  UITextField+ynInputLimit.m
//  ynCategories-Demo
//
//  Created by runlin on 2016/11/29.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "UITextField+YNInputLimit.h"
#import <objc/runtime.h>

static const void *YNTextFieldInputLimitMaxLength = &YNTextFieldInputLimitMaxLength;
@implementation UITextField (YNInputLimit)

- (NSInteger)yn_maxLength {
    return [objc_getAssociatedObject(self, YNTextFieldInputLimitMaxLength) integerValue];
}
- (void)setYn_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, YNTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(yn_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)yn_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.yn_maxLength > 0 && toBeString.length > self.yn_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.yn_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.yn_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.yn_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.yn_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
@end
