//
//  UIButton+Submitting.m
//  FXCategories
//
//  Created by foxsofter on 15/4/2.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "UIButton+YNSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *yn_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *yn_spinnerView;
@property(nonatomic, strong) UILabel *yn_spinnerTitleLabel;

@end

@implementation UIButton (ynSubmitting)

- (void)yn_beginSubmitting:(NSString *)title {
    [self yn_endSubmitting];
    
    self.yn_submitting = @YES;
    self.hidden = YES;
    
    self.yn_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.yn_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.yn_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.yn_modalView.layer.borderWidth = self.layer.borderWidth;
    self.yn_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.yn_modalView.bounds;
    self.yn_spinnerView = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.yn_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.yn_spinnerView.bounds;
    self.yn_spinnerView.frame = CGRectMake(
                                        15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                        spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.yn_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.yn_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.yn_spinnerTitleLabel.text = title;
    self.yn_spinnerTitleLabel.font = self.titleLabel.font;
    self.yn_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.yn_modalView addSubview:self.yn_spinnerView];
    [self.yn_modalView addSubview:self.yn_spinnerTitleLabel];
    [self.superview addSubview:self.yn_modalView];
    [self.yn_spinnerView startAnimating];
}

- (void)yn_endSubmitting {
    if (!self.isYnSubmitting.boolValue) {
        return;
    }
    
    self.yn_submitting = @NO;
    self.hidden = NO;
    
    [self.yn_modalView removeFromSuperview];
    self.yn_modalView = nil;
    self.yn_spinnerView = nil;
    self.yn_spinnerTitleLabel = nil;
}

- (NSNumber *)isYnSubmitting {
    return objc_getAssociatedObject(self, @selector(setYn_submitting:));
}

- (void)setYn_submitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setYn_submitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)yn_spinnerView {
    return objc_getAssociatedObject(self, @selector(setYn_spinnerView:));
}

- (void)setYn_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setYn_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)yn_modalView {
    return objc_getAssociatedObject(self, @selector(setYn_modalView:));

}

- (void)setYn_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setYn_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)yn_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setYn_spinnerTitleLabel:));
}

- (void)setYn_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setYn_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
