//
//  UIView+Animation.h
//  CoolUIViewAnimations
//
//  Created by Peter de Tagyos on 12/10/11.
//  Copyright (c) 2011 PT Software Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

float yn_radiansForDegrees(int degrees);

@interface UIView (ynAnimation)

// Moves
- (void)yn_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)yn_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)yn_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)yn_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)yn_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)yn_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)yn_spinClockwise:(float)secs;
- (void)yn_spinCounterClockwise:(float)secs;

// Transitions
- (void)yn_curlDown:(float)secs;
- (void)yn_curlUpAndAway:(float)secs;
- (void)yn_drainAway:(float)secs;

// Effects
- (void)yn_changeAlpha:(float)newAlpha secs:(float)secs;
- (void)yn_pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)yn_addSubviewWithFadeAnimation:(UIView *)subview;

@end
