//
//  NSObject+YNBlockTimer.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YNBlockTimer)

-(void)yn_logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString*) prefixString;

@end
