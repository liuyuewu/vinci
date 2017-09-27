//
//  NSUserDefaults+SafeAccess.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/23.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#define user_default [NSUserDefaultRecord class]

@interface NSUserDefaults (YNSafeAccess)
+ (NSString *)yn_stringForKey:(NSString *)defaultName;

+ (NSArray *)yn_arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)yn_dictionaryForKey:(NSString *)defaultName;

+ (NSData *)yn_dataForKey:(NSString *)defaultName;

+ (NSArray *)yn_stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)yn_integerForKey:(NSString *)defaultName;

+ (float)yn_floatForKey:(NSString *)defaultName;

+ (double)yn_doubleForKey:(NSString *)defaultName;

+ (BOOL)yn_boolForKey:(NSString *)defaultName;

+ (NSURL *)yn_URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)yn_setObject:(id)value forKey:(NSString *)defaultName;
+ (void)yn_setBool:(BOOL)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)yn_arcObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)yn_setArcObject:(id)value forKey:(NSString *)defaultName;

+(void)removeObjcFromDefaultWithKey:(NSString *)key;


@end
