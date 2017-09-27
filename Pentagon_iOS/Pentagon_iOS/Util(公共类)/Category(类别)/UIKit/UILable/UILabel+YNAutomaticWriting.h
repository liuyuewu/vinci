//
//  UILabel+AutomaticWriting.h
//  UILabel-AutomaticWriting
//
//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//  https://github.com/alexruperez/UILabel-AutomaticWriting

#import <UIKit/UIKit.h>

//! Project version number for UILabel-AutomaticWriting.
FOUNDATION_EXPORT double UILabelAutomaticWritingVersionNumber;

//! Project version string for UILabel-AutomaticWriting.
FOUNDATION_EXPORT const unsigned char UILabelAutomaticWritingVersionString[];

extern NSTimeInterval const UILabelAWDefaultDuration;

extern unichar const UILabelAWDefaultCharacter;

typedef NS_ENUM(NSInteger, UILabelYNlinkingMode)
{
    UILabelYNlinkingModeNone,
    UILabelYNlinkingModeUntilFinish,
    UILabelYNlinkingModeUntilFinishKeeping,
    UILabelYNlinkingModeWhenFinish,
    UILabelYNlinkingModeWhenFinishShowing,
    UILabelYNlinkingModeAlways
};

@interface UILabel (YNAutomaticWriting)

@property (strong, nonatomic) NSOperationQueue *yn_automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets yn_edgeInsets;

- (void)yn_setTextWithAutomaticWritingAnimation:(NSString *)text;

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelYNlinkingMode)blinkingMode;

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelYNlinkingMode)blinkingMode;

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelYNlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelYNlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;

@end
