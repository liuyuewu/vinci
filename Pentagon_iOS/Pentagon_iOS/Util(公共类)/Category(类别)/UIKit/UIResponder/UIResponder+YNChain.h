//
//  UIResponder+ynChain.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (YNChain)
/**
 *  @brief  响应者链
 *
 *  @return  响应者链
 */
- (NSString *)yn_responderChainDescription;
@end
