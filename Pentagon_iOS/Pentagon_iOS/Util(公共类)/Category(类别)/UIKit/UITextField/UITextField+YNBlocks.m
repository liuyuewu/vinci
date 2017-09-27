//
// UITextField+Blocks.m
// UITextFieldBlocks
//
// Created by Håkon Bogen on 19.10.13.
// Copyright (c) 2013 Håkon Bogen. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
#import "UITextField+YNBlocks.h"
#import <objc/runtime.h>
typedef BOOL (^YNUITextFieldReturnBlock) (UITextField *textField);
typedef void (^YNUITextFieldVoidBlock) (UITextField *textField);
typedef BOOL (^YNUITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (YNBlocks)
static const void *YNUITextFieldDelegateKey = &YNUITextFieldDelegateKey;
static const void *YNUITextFieldShouldBeginEditingKey = &YNUITextFieldShouldBeginEditingKey;
static const void *YNUITextFieldShouldEndEditingKey = &YNUITextFieldShouldEndEditingKey;
static const void *YNUITextFieldDidBeginEditingKey = &YNUITextFieldDidBeginEditingKey;
static const void *YNUITextFieldDidEndEditingKey = &YNUITextFieldDidEndEditingKey;
static const void *YNUITextFieldShouldChangeCharactersInRangeKey = &YNUITextFieldShouldChangeCharactersInRangeKey;
static const void *YNUITextFieldShouldClearKey = &YNUITextFieldShouldClearKey;
static const void *YNUITextFieldShouldReturnKey = &YNUITextFieldShouldReturnKey;
#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    YNUITextFieldReturnBlock block = textField.yn_shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, YNUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    YNUITextFieldReturnBlock block = textField.yn_shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, YNUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDidBeginEditing:(UITextField *)textField
{
   YNUITextFieldVoidBlock block = textField.yn_didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, YNUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(UITextField *)textField
{
    YNUITextFieldVoidBlock block = textField.yn_didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, YNUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    YNUITextFieldCharacterChangeBlock block = textField.yn_shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, YNUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(UITextField *)textField
{
    YNUITextFieldReturnBlock block = textField.yn_shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, YNUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    YNUITextFieldReturnBlock block = textField.yn_shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, YNUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}
#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))yn_shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, YNUITextFieldShouldBeginEditingKey);
}
- (void)setYn_shouldBegindEditingBlock:(BOOL (^)(UITextField *))shouldBegindEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YNUITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))yn_shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, YNUITextFieldShouldEndEditingKey);
}
- (void)setYn_shouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YNUITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))yn_didBeginEditingBlock
{
    return objc_getAssociatedObject(self, YNUITextFieldDidBeginEditingKey);
}
- (void)setYn_didBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YNUITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))yn_didEndEditingBlock
{
    return objc_getAssociatedObject(self, YNUITextFieldDidEndEditingKey);
}
- (void)setYn_didEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YNUITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *, NSRange, NSString *))yn_shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, YNUITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setYn_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YNUITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))yn_shouldReturnBlock
{
    return objc_getAssociatedObject(self, YNUITextFieldShouldReturnKey);
}
- (void)setYn_shouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YNUITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))yn_shouldClearBlock
{
    return objc_getAssociatedObject(self, YNUITextFieldShouldClearKey);
}
- (void)setYn_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YNUITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}
#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)yn_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, YNUITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
@end
