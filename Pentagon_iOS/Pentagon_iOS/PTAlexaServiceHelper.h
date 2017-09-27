//
//  PTAlexaServiceHelper.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/7/7.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LoginWithAmazon/LoginWithAmazon.h>


@interface PTAlexaServiceHelper : NSObject

@property (strong, nonatomic) NSString *codeString;
@property (strong, nonatomic) NSString *redirect_url;
@property (strong, nonatomic) NSString *verifyCode;
@property (strong, nonatomic) NSString *client_id;
@property (strong, nonatomic) NSString *refreshToken;

@property (strong, nonatomic) void (^loginSuccess)(AMZNUser *user);
@property (strong, nonatomic) void (^loadingBlock)();
@property (strong, nonatomic) void (^loginFailed)();

+ (instancetype) shareAlexaService;
- (void)signIn;
- (void)signOut;

@end
