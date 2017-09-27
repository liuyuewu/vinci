//
//  NSString+Base64.h
//  Pentagon_iOS
//
//  Created by LiuJiandong on 2017/8/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

@end
