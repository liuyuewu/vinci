//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YNGIF)

+ (UIImage *)yn_animatedGIFNamed:(NSString *)name;

+ (UIImage *)yn_animatedGIFWithData:(NSData *)data;

- (UIImage *)yn_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
