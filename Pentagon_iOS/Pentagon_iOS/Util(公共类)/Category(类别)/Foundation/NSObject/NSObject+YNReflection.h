//
//  NSObject+YNReflection.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/5.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YNReflection)

//类名
- (NSString *)yn_className;
+ (NSString *)yn_className;
//父类名称
- (NSString *)yn_superClassName;
+ (NSString *)yn_superClassName;

//实例属性字典
-(NSDictionary *)yn_propertyDictionary;

//属性名称列表
- (NSArray*)yn_propertyKeys;
+ (NSArray *)yn_propertyKeys;

//属性详细信息列表
- (NSArray *)yn_propertiesInfo;
+ (NSArray *)yn_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)yn_propertiesWithCodeFormat;

//方法列表xf
-(NSArray*)yn_methodList;
+(NSArray*)yn_methodList;

-(NSArray*)yn_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)yn_registedClassList;
//实例变量
+ (NSArray *)yn_instanceVariable;

//协议列表
-(NSDictionary *)yn_protocolList;
+ (NSDictionary *)yn_protocolList;


- (BOOL)yn_hasPropertyForKey:(NSString*)key;
- (BOOL)yn_hasIvarForKey:(NSString*)key;


@end
