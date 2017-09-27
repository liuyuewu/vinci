//
//  PDUrlArgumentsFilter.h
//  Panda
//
//  Created by 王阳 on 2017/1/14.
//  Copyright © 2017年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDUrlArgumentsFilter : NSObject <YTKUrlFilterProtocol>

+ (PDUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;
@end
