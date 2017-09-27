//
//  MFTextField.h
//  MrFan
//
//  Created by 武建明 on 16/5/6.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFTextField : UITextField

/**
 *  是否有下划线
 */
@property (assign, nonatomic)BOOL hasUnderline;

/**
 *  下划线的颜色
 */
@property (strong, nonatomic) UIColor *underlineColor;

/**
 *  设置Placeholder的文字颜色
 */
@property (strong, nonatomic) UIColor *placeholderTextColor;

/**
 *  设置Placeholder的文字大小
 */
@property (assign, nonatomic)CGFloat placeholderFont;

@property (assign, nonatomic)CGFloat textRightOffset;

@property (assign, nonatomic)CGFloat leftTextOffset;

@end
