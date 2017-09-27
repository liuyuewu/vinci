//
//  NSDecimalNumber+Extensions.m
//  CocoaExtensions
//
//  Created by Lars Kuhnt on 11.03.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "NSDecimalNumber+YNExtensions.h"

@implementation NSDecimalNumber (YNExtensions)
/**
 *  @brief  四舍五入 NSRoundPlain
 *
 *  @param scale 限制位数
 *
 *  @return 返回结果
 */
- (NSDecimalNumber *)yn_roundToScale:(NSUInteger)scale{
    return [self yn_roundToScale:scale mode:NSRoundPlain];
}
/**
 *  @brief  四舍五入
 *
 *  @param scale        限制位数
 *  @param roundingMode NSRoundingMode
 *
 *  @return 返回结果
 */
- (NSDecimalNumber *)yn_roundToScale:(NSUInteger)scale mode:(NSRoundingMode)roundingMode{
  NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
  return [self decimalNumberByRoundingAccordingToBehavior:handler];
}

- (NSDecimalNumber*)yn_decimalNumberWithPercentage:(float)percent {
  NSDecimalNumber * percentage = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:percent] decimalValue]];
  return [self decimalNumberByMultiplyingBy:percentage];
}

- (NSDecimalNumber *)yn_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage {
  NSDecimalNumber * hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
  NSDecimalNumber * percent = [self decimalNumberByMultiplyingBy:[discountPercentage decimalNumberByDividingBy:hundred]];
  return [self decimalNumberBySubtracting:percent];
}

- (NSDecimalNumber *)yn_decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage roundToScale:(NSUInteger)scale {
  NSDecimalNumber * value = [self yn_decimalNumberWithDiscountPercentage:discountPercentage];
  return [value yn_roundToScale:scale];
}

- (NSDecimalNumber *)yn_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue {
  NSDecimalNumber * hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
  NSDecimalNumber * percentage = [[self decimalNumberByDividingBy:baseValue] decimalNumberByMultiplyingBy:hundred];
  return [hundred decimalNumberBySubtracting:percentage];
}

- (NSDecimalNumber *)yn_discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue roundToScale:(NSUInteger)scale {
  NSDecimalNumber * discount = [self yn_discountPercentageWithBaseValue:baseValue];
  return [discount yn_roundToScale:scale];
}

@end
