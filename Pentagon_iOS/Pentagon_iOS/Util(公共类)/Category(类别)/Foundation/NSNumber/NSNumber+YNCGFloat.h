
//
//  NSNumber+CGFloat.h
//
//  Created by Alexey Aleshkov on 16.02.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (YNCGFloat)

- (CGFloat)yn_CGFloatValue;

- (id)initWithynCGFloat:(CGFloat)value;

+ (NSNumber *)yn_numberWithCGFloat:(CGFloat)value;

@end
