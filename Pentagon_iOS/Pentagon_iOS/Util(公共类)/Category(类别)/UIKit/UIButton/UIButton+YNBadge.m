//
//  UIBarButtonItem+Badge.m
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//
#import <objc/runtime.h>
#import "UIButton+YNBadge.h"

NSString const *yn_UIButton_badgeKey = @"yn_UIButton_badgeKey";

NSString const *yn_UIButton_badgeBGColorKey = @"yn_UIButton_badgeBGColorKey";
NSString const *yn_UIButton_badgeTextColorKey = @"yn_UIButton_badgeTextColorKey";
NSString const *yn_UIButton_badgeFontKey = @"yn_UIButton_badgeFontKey";
NSString const *yn_UIButton_badgePaddingKey = @"yn_UIButton_badgePaddingKey";
NSString const *yn_UIButton_badgeMinSizeKey = @"yn_UIButton_badgeMinSizeKey";
NSString const *yn_UIButton_badgeOriginXKey = @"yn_UIButton_badgeOriginXKey";
NSString const *yn_UIButton_badgeOriginYKey = @"yn_UIButton_badgeOriginYKey";
NSString const *yn_UIButton_shouldHideBadgeAtZeroKey = @"yn_UIButton_shouldHideBadgeAtZeroKey";
NSString const *yn_UIButton_shouldAnimateBadgeKey = @"yn_UIButton_shouldAnimateBadgeKey";
NSString const *yn_UIButton_badgeValueKey = @"yn_UIButton_badgeValueKey";

@implementation UIButton (YNBadge)

@dynamic yn_badgeValue, yn_badgeBGColor, yn_badgeTextColor, yn_badgeFont;
@dynamic yn_badgePadding, yn_badgeMinSize, yn_badgeOriginX, yn_badgeOriginY;
@dynamic yn_shouldHideBadgeAtZero, yn_shouldAnimateBadge;

- (void)yn_badgeInit
{
    // Default design initialization
    self.yn_badgeBGColor   = [UIColor redColor];
    self.yn_badgeTextColor = [UIColor whiteColor];
    self.yn_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.yn_badgePadding   = 6;
    self.yn_badgeMinSize   = 8;
    self.yn_badgeOriginX   = self.frame.size.width - self.yn_badge.frame.size.width/2;
    self.yn_badgeOriginY   = -4;
    self.yn_shouldHideBadgeAtZero = YES;
    self.yn_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)yn_refreshBadge
{
    // Change new attributes
    self.yn_badge.textColor        = self.yn_badgeTextColor;
    self.yn_badge.backgroundColor  = self.yn_badgeBGColor;
    self.yn_badge.font             = self.yn_badgeFont;
}

- (CGSize) yn_badgeExpectedSize
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
    self.yn_badge.frame = CGRectMake(self.yn_badgeOriginX, self.yn_badgeOriginY, minWidth + padding, minHeight + padding);
    self.yn_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.yn_badge.layer.masksToBounds = YES;
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
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self yn_updateBadgeFrame];
    }];
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
    return objc_getAssociatedObject(self, &yn_UIButton_badgeKey);
}
-(void)setYn_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &yn_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)yn_badgeValue {
    return objc_getAssociatedObject(self, &yn_UIButton_badgeValueKey);
}
-(void) setYn_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &yn_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.yn_shouldHideBadgeAtZero)) {
        [self yn_removeBadge];
    } else if (!self.yn_badge) {
        // Create a new badge because not existing
        self.yn_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.yn_badgeOriginX, self.yn_badgeOriginY, 20, 20)];
        self.yn_badge.textColor            = self.yn_badgeTextColor;
        self.yn_badge.backgroundColor      = self.yn_badgeBGColor;
        self.yn_badge.font                 = self.yn_badgeFont;
        self.yn_badge.textAlignment        = NSTextAlignmentCenter;
        [self yn_badgeInit];
        [self addSubview:self.yn_badge];
        [self yn_updateBadgeValueAnimated:NO];
    } else {
        [self yn_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)yn_badgeBGColor {
    return objc_getAssociatedObject(self, &yn_UIButton_badgeBGColorKey);
}
-(void)setYn_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &yn_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_refreshBadge];
    }
}

// Badge text color
-(UIColor *)yn_badgeTextColor {
    return objc_getAssociatedObject(self, &yn_UIButton_badgeTextColorKey);
}
-(void)setYn_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &yn_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_refreshBadge];
    }
}

// Badge font
-(UIFont *)yn_badgeFont {
    return objc_getAssociatedObject(self, &yn_UIButton_badgeFontKey);
}
-(void)setYn_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &yn_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) yn_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setYn_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &yn_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) yn_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setYn_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &yn_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) yn_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setYn_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &yn_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

-(CGFloat) yn_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setYn_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &yn_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.yn_badge) {
        [self yn_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) yn_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setYn_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &yn_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) yn_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &yn_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setYn_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &yn_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
