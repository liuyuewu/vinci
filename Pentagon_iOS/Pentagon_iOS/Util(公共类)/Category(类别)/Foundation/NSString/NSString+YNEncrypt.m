//
//  NSString+YNEncrypt.m
//  YNCommonProject
//
//  Created by 王阳 on 2016/11/30.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import "NSString+YNEncrypt.h"
#import "NSData+YNEncrypt.h"
#import "NSData+YNBase64.h"

@implementation NSString (YNEncrypt)

-(NSString*)yn_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] yn_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted yn_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)yn_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData yn_dataWithBase64EncodedString:self] yn_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)yn_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] yn_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted yn_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)yn_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData yn_dataWithBase64EncodedString:self] yn_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}


@end
