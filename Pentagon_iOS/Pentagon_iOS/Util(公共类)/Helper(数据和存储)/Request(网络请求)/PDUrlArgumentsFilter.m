//
//  PDUrlArgumentsFilter.m
//  Panda
//
//  Created by 王阳 on 2017/1/14.
//  Copyright © 2017年 王阳. All rights reserved.
//

#import "PDUrlArgumentsFilter.h"
#import <AFURLRequestSerialization.h>

@implementation PDUrlArgumentsFilter{
    NSDictionary *_arguments;
}


+ (PDUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    for (NSString *key in arguments.allKeys) {
        if (!arguments[key]) {
            [arguments setValue:@"" forKey:key];
        }
    }
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [self urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    } else {
        return originUrlString;
    }
}

- (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters {
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0) {
        for (NSString *key in parameters) {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            value = [self urlEncode:value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

- (NSString*)urlEncode:(NSString*)str {
    return AFPercentEscapedStringFromString(str);
}

@end
