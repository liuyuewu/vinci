//
//  PTBaseModel.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBaseModel.h"

@implementation PTBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    debugLog(@"******* undeifined key = %@*******",key);
}

@end
