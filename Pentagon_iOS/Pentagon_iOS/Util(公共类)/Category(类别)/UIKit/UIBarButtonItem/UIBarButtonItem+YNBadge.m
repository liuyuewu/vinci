//
//  UIBarButtonItem+Badge.m
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//
#import <objc/runtime.h>
#import "UIBarButtonItem+YNBadge.h"

NSString const *yn_UIBarButtonItem_badgeKey = @"yn_UIBarButtonItem_badgeKey";

NSString const *yn_UIBarButtonItem_badgeBGColorKey = @"yn_UIBarButtonItem_badgeBGColorKey";
NSString const *yn_UIBarButtonItem_badgeTextColorKey = @"yn_UIBarButtonItem_badgeTextColorKey";
NSString const *yn_UIBarButtonItem_badgeFontKey = @"yn_UIBarButtonItem_badgeFontKey";
NSString const *yn_UIBarButtonItem_badgePaddingKey = @"yn_UIBarButtonItem_badgePaddingKey";
NSString const *yn_UIBarButtonItem_badgeMinSizeKey = @"yn_UIBarButtonItem_badgeMinSizeKey";
NSString const *yn_UIBarButtonItem_badgeOriginXKey = @"yn_UIBarButtonItem_badgeOriginXKey";
NSString const *yn_UIBarButtonItem_badgeOriginYKey = @"yn_UIBarButtonItem_badgeOriginYKey";
NSString const *yn_UIBarButtonItem_shouldHideBadgeAtZeroKey = @"yn_UIBarButtonItem_shouldHideBadgeAtZeroKey";
NSString const *yn_UIBarButtonItem_shouldAnimateBadgeKey = @"yn_UIBarButtonItem_shouldAnimateBadgeKey";
NSString const *yn_UIBarButtonItem_badgeValueKey = @"yn_UIBarButtonItem_badgeValueKey";

@implementation UIBarButtonItem (YNBadge)

@dynamic yn_badgeValue, yn_badgeBGColor, yn_badgeTextColor, yn_badgeFont;
@dynamic yn_badgePadding, yn_badgeMinSize, yn_badgeOriginX, yn_badgeOriginY;
@dynamic yn_shouldHideBadgeAtZero, yn_shouldAnimateBadge;

- (void)yn_badgeInit
{
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.yn_badge.frame.size.width/2;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.yn_badge.frame.size.width;
    }
    [superview addSubview:self.yn_badge];
    
    // Default design initialization
    self.yn_badgeBGColor   = [UIColor redColor];
    self.yn_badgeTextColor = [UIColor whiteColor];
    self.yn_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.yn_badgePadding   = 6;
    self.yn_badgeMinSize   = 8;
    self.yn_badgeOriginX   = defaultOriginX;
    self.yn_badgeOriginY   = -4;
    self.yn_shouldHideBadgeAtZero = YES;
    self.yn_shouldAnimateBadge = YES;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)yn_refreshBadge
{
    // Change new attributes
    self.yn_badge.textColor        = self.yn_badgeTextColor;
    self.yn_badge.backgroundColor  = self.yn_badgeBGColor;
    self.yn_badge.font             = self.yn_badgeFont;
    
    if (!self.yn_badgeValue || [self.yn_badgeValue isEqualToString:@""] || ([self.yn_badgeValue isEqualToString:@"0"] && self.yn_shouldHideBadgeAtZero)) {
        self.yn_badge.hidden = YES;
    } else {
        self.yn_badge.hidden = NO;
        [self yn_updateBadgeValueAnimated:YES];
    }

}

- (CGSize)yn_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self yn_duplicateLabel:self.yn_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)yn_updateBadgeFrame
{

    CGSize expectedLabelSize = [self yn_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.yn_badgeMinSize) ? self.yn_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.yn_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.yn_badge.layer.masksToBounds = YES;
    self.yn_badge.frame = CGRectMake(self.yn_badgeOriginX, self.yn_badgeOriginY, minWidth + padding, minHeight + padding);
    self.yn_badge.layer.cornerRadius = (minHeight + padding) / 2;
}

// Handle the badge changing value
- (void)yn_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.yn_shouldAnimateBadge && ![self.yn_badge.text isEqualToString:self.yn_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.yn_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.yn_badge.text = self.yn_badgeValue;
    
    // Animate the size modification if needed
    if (animated && self.yn_shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self yn_updateBadgeFrame];
        }];
    } else {
        [self yn_updateBadgeFrame];
    }
}

- (UILabel *)yn_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)yn_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.yn_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.yn_badge removeFromSuperview];
        self.yn_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)yn_badge {
    UILabel* lbl = objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeKey);
    if(lbl==nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.yn_badgeOriginX, self.yn_badgeOriginY, 20, 20)];
        [self setYn_badge:lbl];
        [self yn_badgeInit];
        [self.customView addSubview:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    return lbl;
}
-(void)setYn_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)yn_badgeValue {
    return objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeValueKey);
}
-(void)setYn_vadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    [self yn_updateBadgeValueAnimated:YES];
    [self yn_refreshBadge];
}

// Badge background color
-(UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeBGColorKey);
}
-(void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_refreshBadge];
    }
}

// Badge text color
-(UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeTextColorKey);
}
-(void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_refreshBadge];
    }
}

// Badge font
-(UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeFontKey);
}
-(void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgePaddingKey);
    return number.floatValue;
}
-(void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat)yn_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setyn_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat)yn_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}
-(void) setyn_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

-(CGFloat)yn_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}
-(void) setyn_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIBarButtonItem_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.yn_badge) {
        [self yn_refreshBadge];
    }
}

// Badge has a bounce animation when value changes
-(BOOL) yn_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIBarButtonItem_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setyn_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &yn_UIBarButtonItem_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.yn_badge) {
        [self yn_refreshBadge];
    }
}


@end
