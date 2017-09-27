//
//  NSBundle+YNAppIcon.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/6.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSBundle+YNAppIcon.h"

@implementation NSBundle (YNAppIcon)

- (NSString*)yn_appIconPath {
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

- (UIImage*)yn_appIcon {
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self yn_appIconPath]] ;
    return appIcon;
}

@end
