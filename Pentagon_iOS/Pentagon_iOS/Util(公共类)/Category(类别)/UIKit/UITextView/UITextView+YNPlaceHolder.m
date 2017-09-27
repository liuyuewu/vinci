//
//  UITextView+PlaceHolder.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UITextView+YNPlaceHolder.h"
static const char *yn_placeHolderTextView = "yn_placeHolderTextView";
@implementation UITextView (YNPlaceHolder)
- (UITextView *)yn_placeHolderTextView {
    return objc_getAssociatedObject(self, yn_placeHolderTextView);
}
- (void)setYn_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, yn_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)yn_addPlaceHolder:(NSString *)placeHolder {
    if (![self yn_placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = K_Color_06;
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setYn_placeHolderTextView:textView];
    }
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.yn_placeHolderTextView.hidden = YES;
    // if (self.textViewDelegate) {
    //
    // }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.yn_placeHolderTextView.hidden = NO;
    }
}

@end
