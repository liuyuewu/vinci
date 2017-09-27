//
//  NSObject+YNAutoCoding.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YNAutoCoding)

//coding
+ (NSDictionary *)yn_codableProperties;
- (void)yn_setWithCoder:(NSCoder *)aDecoder;
//property access
- (NSDictionary *)yn_codableProperties;
- (NSDictionary *)yn_dictionaryRepresentation;
//loading / saving
+ (instancetype)yn_objectWithContentsOfFile:(NSString *)path;
- (BOOL)yn_writeToFile:(NSString *)filePath atomically:(BOOL)useAuxiliaryFile;

@end
