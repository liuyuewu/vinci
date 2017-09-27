//
//  NSArray+YNSafeAccess.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YNSafeAccess)
-(id)yn_objectWithIndex:(NSUInteger)index;

- (NSString*)yn_stringWithIndex:(NSUInteger)index;

- (NSNumber*)yn_numberWithIndex:(NSUInteger)index;

- (NSDecimalNumber *)yn_decimalNumberWithIndex:(NSUInteger)index;

- (NSArray*)yn_arrayWithIndex:(NSUInteger)index;

- (NSDictionary*)yn_dictionaryWithIndex:(NSUInteger)index;

- (NSInteger)yn_integerWithIndex:(NSUInteger)index;

- (NSUInteger)yn_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)yn_boolWithIndex:(NSUInteger)index;

- (int16_t)yn_int16WithIndex:(NSUInteger)index;

- (int32_t)yn_int32WithIndex:(NSUInteger)index;

- (int64_t)yn_int64WithIndex:(NSUInteger)index;

- (char)yn_charWithIndex:(NSUInteger)index;

- (short)yn_shortWithIndex:(NSUInteger)index;

- (float)yn_floatWithIndex:(NSUInteger)index;

- (double)yn_doubleWithIndex:(NSUInteger)index;

- (NSDate *)yn_dateWithIndex:(NSUInteger)index dateFormat:(NSString *)dateFormat;
//CG
- (CGFloat)yn_CGFloatWithIndex:(NSUInteger)index;

- (CGPoint)yn_pointWithIndex:(NSUInteger)index;

- (CGSize)yn_sizeWithIndex:(NSUInteger)index;

- (CGRect)yn_rectWithIndex:(NSUInteger)index;
@end


#pragma --mark NSMutableArray setter

@interface NSMutableArray(YNSafeAccess)

-(void)yn_addObj:(id)i;

-(void)yn_addString:(NSString*)i;

-(void)yn_addBool:(BOOL)i;

-(void)yn_addInt:(int)i;

-(void)yn_addInteger:(NSInteger)i;

-(void)yn_addUnsignedInteger:(NSUInteger)i;

-(void)yn_addCGFloat:(CGFloat)f;

-(void)yn_addChar:(char)c;

-(void)yn_addFloat:(float)i;

-(void)yn_addPoint:(CGPoint)o;

-(void)yn_addSize:(CGSize)o;

-(void)yn_addRect:(CGRect)o;
@end
