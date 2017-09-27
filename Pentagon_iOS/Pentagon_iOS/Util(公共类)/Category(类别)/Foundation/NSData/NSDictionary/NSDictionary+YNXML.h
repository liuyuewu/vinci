//
//  NSDictionary+YNXML.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YNXML)

/**
 *  @brief  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)yn_XMLString;

@end
