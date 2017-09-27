//
//  NSObject+YNAddProperty.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSObject+YNAddProperty.h"
#import <objc/runtime.h>
//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
static const void *ynStringProperty = &ynStringProperty;
static const void *ynIntegerProperty = &ynIntegerProperty;
//static char IntegerProperty;
@implementation NSObject (YNAddProperty)

@dynamic yn_stringProperty;
@dynamic yn_integerProperty;

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
-(void)setYn_stringProperty:(NSString *)yn_stringProperty{
    //use that a static const as the key
    objc_setAssociatedObject(self, ynStringProperty, yn_stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //use that property's selector as the key:
    //objc_setAssociatedObject(self, @selector(stringProperty), stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
-(NSString *)yn_stringProperty{
    return objc_getAssociatedObject(self, ynStringProperty);
}

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
-(void)setYn_integerProperty:(NSInteger)yn_integerProperty{
    NSNumber *number = [[NSNumber alloc]initWithInteger:yn_integerProperty];
    objc_setAssociatedObject(self,ynIntegerProperty, number, OBJC_ASSOCIATION_ASSIGN);
}
//get
-(NSInteger)yn_integerProperty{
    return [objc_getAssociatedObject(self, ynIntegerProperty) integerValue];
}


@end
