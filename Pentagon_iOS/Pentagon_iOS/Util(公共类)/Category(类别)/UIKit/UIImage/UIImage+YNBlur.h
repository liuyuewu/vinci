//
//  UIImage+Blur.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/6/5.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double ImageEffectsVersionNumber;
FOUNDATION_EXPORT const unsigned char ImageEffectsVersionString[];
@interface UIImage (YNBlur)

- (UIImage *)yn_lightImage;
- (UIImage *)yn_extraLightImage;
- (UIImage *)yn_darkImage;
- (UIImage *)yn_tintedImageWithColor:(UIColor *)tintColor;

- (UIImage *)yn_blurredImageWithRadius:(CGFloat)blurRadius;
- (UIImage *)yn_blurredImageWithSize:(CGSize)blurSize;
- (UIImage *)yn_blurredImageWithSize:(CGSize)blurSize
                        tintColor:(UIColor *)tintColor
            saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                        maskImage:(UIImage *)maskImage;
@end
