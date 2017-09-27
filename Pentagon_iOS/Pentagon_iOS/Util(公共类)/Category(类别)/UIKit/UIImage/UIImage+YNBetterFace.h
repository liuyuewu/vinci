//
//  UIImage+BetterFace.h
//  bf
//
//  Created by liuyan on 13-11-25.
//  Copyright (c) 2013年 Croath. All rights reserved.
//
// https://github.com/croath/UIImageView-BetterFace
//  a UIImageView category to let the picture-cutting with faces showing better

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YNAccuracy) {
    YNAccuracyLow = 0,
    YNAccuracyHigh,
};

@interface UIImage (YNBetterFace)

- (UIImage *)yn_betterFaceImageForSize:(CGSize)size
                           accuracy:(YNAccuracy)accurary;

@end
