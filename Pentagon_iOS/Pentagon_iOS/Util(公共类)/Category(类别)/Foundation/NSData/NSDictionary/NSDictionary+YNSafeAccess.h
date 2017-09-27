//
//  NSDictionary+YNSafeAccess.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YNSafeAccess)

- (BOOL)yn_hasKey:(NSString *)key;

- (NSString*)yn_stringForKey:(id)key;

- (NSNumber*)yn_numberForKey:(id)key;

- (NSDecimalNumber *)yn_decimalNumberForKey:(id)key;

- (NSArray*)yn_arrayForKey:(id)key;

- (NSDictionary*)yn_dictionaryForKey:(id)key;

- (NSInteger)yn_integerForKey:(id)key;

- (NSUInteger)yn_unsignedIntegerForKey:(id)key;

- (BOOL)yn_boolForKey:(id)key;

- (int16_t)yn_int16ForKey:(id)key;

- (int32_t)yn_int32ForKey:(id)key;

- (int64_t)yn_int64ForKey:(id)key;

- (char)yn_charForKey:(id)key;

- (short)yn_shortForKey:(id)key;

- (float)yn_floatForKey:(id)key;

- (double)yn_doubleForKey:(id)key;

- (long long)yn_longLongForKey:(id)key;

- (unsigned long long)yn_unsignedLongLongForKey:(id)key;

- (NSDate *)yn_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

//CG
- (CGFloat)yn_CGFloatForKey:(id)key;

- (CGPoint)yn_pointForKey:(id)key;

- (CGSize)yn_sizeForKey:(id)key;

- (CGRect)yn_rectForKey:(id)key;
@end

#pragma --mark NSMutableDictionary setter

@interface NSMutableDictionary(YNSafeAccess)

-(void)yn_setObj:(id)i forKey:(NSString*)key;

-(void)yn_setString:(NSString*)i forKey:(NSString*)key;

-(void)yn_setBool:(BOOL)i forKey:(NSString*)key;

-(void)yn_setInt:(int)i forKey:(NSString*)key;

-(void)yn_setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)yn_setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)yn_setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)yn_setChar:(char)c forKey:(NSString*)key;

-(void)yn_setFloat:(float)i forKey:(NSString*)key;

-(void)yn_setDouble:(double)i forKey:(NSString*)key;

-(void)yn_setLongLong:(long long)i forKey:(NSString*)key;

-(void)yn_setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)yn_setSize:(CGSize)o forKey:(NSString*)key;

-(void)yn_setRect:(CGRect)o forKey:(NSString*)key;
@end
