//
//  CAMediaTimingFunction+AdditionalEquations.h
//
//  Created by Heiko Dreyer on 02.04.12.
//  Copyright (c) 2012 boxedfolder.com. All rights reserved.
//  https://github.com/bfolder/UIView-Visuals

#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingFunction (YNAdditionalEquations)


///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInCirc;
+(CAMediaTimingFunction *)yn_easeOutCirc;
+(CAMediaTimingFunction *)yn_easeInOutCirc;

///---------------------------------------------------------------------------------------
/// @name Cubic Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInCubic;
+(CAMediaTimingFunction *)yn_easeOutCubic;
+(CAMediaTimingFunction *)yn_easeInOutCubic;

///---------------------------------------------------------------------------------------
/// @name Expo Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInExpo;
+(CAMediaTimingFunction *)yn_easeOutExpo;
+(CAMediaTimingFunction *)yn_easeInOutExpo;

///---------------------------------------------------------------------------------------
/// @name Quad Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInQuad;
+(CAMediaTimingFunction *)yn_easeOutQuad;
+(CAMediaTimingFunction *)yn_easeInOutQuad;

///---------------------------------------------------------------------------------------
/// @name Quart Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInQuart;
+(CAMediaTimingFunction *)yn_easeOutQuart;
+(CAMediaTimingFunction *)yn_easeInOutQuart;

///---------------------------------------------------------------------------------------
/// @name Quint Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInQuint;
+(CAMediaTimingFunction *)yn_easeOutQuint;
+(CAMediaTimingFunction *)yn_easeInOutQuint;

///---------------------------------------------------------------------------------------
/// @name Sine Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInSine;
+(CAMediaTimingFunction *)yn_easeOutSine;
+(CAMediaTimingFunction *)yn_easeInOutSine;

///---------------------------------------------------------------------------------------
/// @name Back Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)yn_easeInBack;
+(CAMediaTimingFunction *)yn_easeOutBack;
+(CAMediaTimingFunction *)yn_easeInOutBack;

@end
