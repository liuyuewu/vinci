//
//  NSFileManager+Paths.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSFileManager+YNPaths.h"
#include <sys/xattr.h>

@implementation NSFileManager (YNPaths)
+ (NSURL *)yn_URLForDirectory:(NSSearchPathDirectory)directory
{
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

+ (NSString *)yn_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)yn_documentsURL
{
    return [self yn_URLForDirectory:NSDocumentDirectory];
}

+ (NSString *)yn_documentsPath
{
    return [self yn_pathForDirectory:NSDocumentDirectory];
}

+ (NSURL *)yn_libraryURL
{
    return [self yn_URLForDirectory:NSLibraryDirectory];
}

+ (NSString *)yn_libraryPath
{
    return [self yn_pathForDirectory:NSLibraryDirectory];
}

+ (NSURL *)yn_cachesURL
{
    return [self yn_URLForDirectory:NSCachesDirectory];
}

+ (NSString *)yn_cachesPath
{
    return [self yn_pathForDirectory:NSCachesDirectory];
}

+ (BOOL)yn_addSkipBackupAttributeToFile:(NSString *)path
{
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

+ (double)yn_availableDiskSpace
{
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.yn_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}
@end
