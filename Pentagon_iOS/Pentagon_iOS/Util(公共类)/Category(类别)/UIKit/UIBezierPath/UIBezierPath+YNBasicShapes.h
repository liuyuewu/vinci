//
//  UIBezierPath+ynBasicShapes.h
//  Example
//
//  Created by Pierre Dulac on 26/02/13.
//  Copyright (c) 2013 Pierre Dulac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (YNBasicShapes)

+ (UIBezierPath *)yn_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)yn_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)yn_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)yn_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)yn_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)yn_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end
