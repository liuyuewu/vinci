//
//  UIBarButtonItem+Badge.h
//  therichest
//
//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//  https://github.com/mikeMTOL/UIBarButtonItem-Badge

#import <UIKit/UIKit.h>

@interface UIButton (YNBadge)

@property (strong, nonatomic) UILabel *yn_badge;

// Badge value to be display
@property (nonatomic) NSString *yn_badgeValue;
// Badge background color
@property (nonatomic) UIColor *yn_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *yn_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *yn_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat yn_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat yn_badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat yn_badgeOriginX;
@property (nonatomic) CGFloat yn_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL yn_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL yn_shouldAnimateBadge;

@end
