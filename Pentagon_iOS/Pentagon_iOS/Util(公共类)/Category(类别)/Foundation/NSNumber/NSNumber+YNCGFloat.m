//
//  NSNumber+CGFloat.m
//
//  Created by Alexey Aleshkov on 16.02.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//

#import "NSNumber+YNCGFloat.h"

@implementation NSNumber (YNCGFloat)

- (CGFloat)yn_CGFloatValue
{
#if (CGFLOAT_IS_DOUBLE == 1)
    CGFloat result = [self doubleValue];
#else
    CGFloat result = [self floatValue];
#endif
    return result;
}

- (id)initWithynCGFloat:(CGFloat)value
{
#if (CGFLOAT_IS_DOUBLE == 1)
    self = [self initWithDouble:value];
#else
    self = [self initWithFloat:value];
#endif
    return self;
}

+ (NSNumber *)yn_numberWithCGFloat:(CGFloat)value
{
    NSNumber *result = [[self alloc] initWithynCGFloat:value];
    return result;
}

@end
