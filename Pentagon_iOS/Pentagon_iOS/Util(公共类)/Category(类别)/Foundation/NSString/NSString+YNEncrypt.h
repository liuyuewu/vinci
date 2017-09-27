//
//  NSString+YNEncrypt.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YNEncrypt)

- (NSString*)yn_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
- (NSString*)yn_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

- (NSString*)yn_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
- (NSString*)yn_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
