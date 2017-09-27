//
//  NSArray+YNSafeAccess.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSArray+YNSafeAccess.h"

@implementation NSArray (YNSafeAccess)
-(id)yn_objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (NSString*)yn_stringWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber*)yn_numberWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)yn_decimalNumberWithIndex:(NSUInteger)index{
    id value = [self yn_objectWithIndex:index];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (NSArray*)yn_arrayWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}


- (NSDictionary*)yn_dictionaryWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSInteger)yn_integerWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)yn_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)yn_boolWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (int16_t)yn_int16WithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)yn_int32WithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int64_t)yn_int64WithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    return 0;
}

- (char)yn_charWithIndex:(NSUInteger)index{
    
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    return 0;
}

- (short)yn_shortWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (float)yn_floatWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)yn_doubleWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

- (NSDate *)yn_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self yn_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)yn_CGFloatWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}

- (CGPoint)yn_pointWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)yn_sizeWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)yn_rectWithIndex:(NSUInteger)index
{
    id value = [self yn_objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}
@end


#pragma --mark NSMutableArray setter
@implementation NSMutableArray (YNSafeAccess)
-(void)yn_addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)yn_addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)yn_addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)yn_addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)yn_addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)yn_addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)yn_addCGFloat:(CGFloat)f
{
    [self addObject:@(f)];
}
-(void)yn_addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)yn_addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)yn_addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)yn_addSize:(CGSize)o
{
    [self addObject:NSStringFromCGSize(o)];
}
-(void)yn_addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}
@end

