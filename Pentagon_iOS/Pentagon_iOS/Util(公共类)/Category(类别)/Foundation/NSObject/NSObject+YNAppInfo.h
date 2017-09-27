//
//  NSObject+YNAppInfo.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>

@interface NSObject (YNAppInfo)

-(NSString *)yn_version;
-(NSInteger)yn_build;
-(NSString *)yn_identifier;
-(NSString *)yn_currentLanguage;
-(NSString *)yn_deviceModel;

@end
