//
//  PTAlexaServiceHelper.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/7/7.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTAlexaServiceHelper.h"
#import <AFNetworking.h>
#import "NSString+YNHash.h"
#import "Base64.h"
#import "CocoaSecurity.h"
#import "NSData+YNHash.h"
#import "PTAlertView.h"
#import "BluetoothManager.h"



@interface PTAlexaServiceHelper ()

@property (strong, nonatomic) AMZNUser *user;


@end

NSString * productId = @"pentagon_device_ios";
NSString * productDsn = @"123456";
NSString * clientID = @"amzn1.application-oa2-client.463851774fcb4626a98967558f587e34";
NSString * clientSecret = @"24670e15c79a9f18ed329bcb6f5cf57ba9dfb2406edb4433c6d439e142288aeb";
NSString * venderID = @"M1Z8R5D0PWDR1H";
NSString * venderCode = @"101CV";
NSString * profilesID = @"amzn1.application.fbc6f64966534a37a180af1ef2328dc1";

@implementation PTAlexaServiceHelper

+ (instancetype) shareAlexaService{
    static PTAlexaServiceHelper *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PTAlexaServiceHelper alloc]init];
    });
    return _instance;
}

- (void)signIn{
    self.verifyCode = [self generateTradeNO];
    
    NSDictionary *scopeData = @{@"productID":productId,
                                @"productInstanceAttributes": @{@"deviceSerialNumber": productDsn}};
    
    id alexaAllScope = [AMZNScopeFactory scopeWithName:@"alexa:all" data:scopeData];
    
    AMZNAuthorizeRequest *request = [[AMZNAuthorizeRequest alloc] init];
    request.scopes = @[alexaAllScope];
    
    request.grantType = AMZNAuthorizationGrantTypeCode;
    
    //encoding
    NSData *data = [self.verifyCode dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodeData = [data yn_sha256Data];
    NSString *encodeString = [encodeData base64EncodedString];
    request.codeChallenge = [self resultString:encodeString];
    request.codeChallengeMethod = @"S256";
    NSLog(@"encode string = %@",[self resultString:encodeString]);
    
    [[AMZNAuthorizationManager sharedManager] authorize:request withHandler:^(AMZNAuthorizeResult *result, BOOL userDidCancel, NSError *error) {
        if (error) {
            
            NSString *errorMessage = error.userInfo[@"AMZNLWAErrorNonLocalizedDescription"];
            
            PTAlertView *alert = [PTAlertView alertView];
            alert.alertType = PTNoticeAlertView;
            alert.message = [NSString stringWithFormat:@"Error occured with message: %@", errorMessage];
            [alert show];

        } else if (userDidCancel) {
//            PTAlertView *alert = [PTAlertView alertView];
//            alert.alertType = PTNoticeAlertView;
//            alert.message = @"User Did Cancel";
//            [alert show];

        } else {
            NSString *accessToken = result.token;
            AMZNUser *user = result.user;
            self.user = user;
            NSString *userID = user.userID;
            NSLog(@"access token = %@ userID = %@ code = %@ redirect url = %@ clientID = %@",accessToken,userID,result.authorizationCode,result.redirectUri,result.clientId);
            
            self.codeString = result.authorizationCode;
            self.redirect_url = result.redirectUri;
            self.client_id = result.clientId;
            [self request];
        }
    }];
    
}

- (void)request{
    
    NSString *urlStr = @"https://api.amazon.com/auth/O2/token";
    NSString *client_secret = [clientSecret stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"grant_type":@"authorization_code",@"code":self.codeString,@"redirect_uri":self.redirect_url,@"client_id":self.client_id,@"client_secret":client_secret,@"code_verifier":self.verifyCode};
    NSLog(@"parameter = %@",dict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        
        NSString *uid = [NSUserDefaults yn_stringForKey:PTGoogleUIDKey];
        NSString *headersetID = [NSUserDefaults yn_stringForKey:PTGoogleHeaderIDKey];
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
     
        [NSUserDefaults yn_setObject:@"1" forKey:@"selectMusicService"];
        [NSUserDefaults yn_setObject:dic[@"access_token"] forKey:PTAlexaAccessToken];
        [NSUserDefaults yn_setObject:dic[@"refresh_token"] forKey:PTAlexaRefreshToken];
        [NSUserDefaults yn_setObject:dic[@"token_type"] forKey:PTAlexaTokenType];
        [NSUserDefaults yn_setObject:@"true" forKey:PTMusicService];

    
        NSDictionary *bluData = @{@"t":@"a",@"a":dic[@"access_token"],@"r":dic[@"refresh_token"]};
        
        NSString *jsonStr = [bluData mj_JSONString];
        
        NSString *baseStr = [jsonStr base64EncodedString];
        
        BluetoothManager *manager = [BluetoothManager shareInstance];
        
        [manager sendValue:baseStr];
        
        self.refreshToken = dic[@"refresh_token"];

//        [[[[self.ref child:@"serviceconfigs"]child:uid]child:headersetID]setValue:@{@"selected":@"Alexa",@"timestamp":[NSNumber numberWithDouble:a],@"headset_id":headersetID,@"access_token":dic[@"access_token"],@"refresh_token":dic[@"refresh_token"]} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
//            
//            if (error) {
//                NSLog(@"write error = %@",[error localizedDescription]);
//                [NSUserDefaults yn_setObject:@"false" forKey:PTMusicService];
//            }else{
//                
//                [NSUserDefaults yn_setObject:@"1" forKey:@"selectMusicService"];
//                
//                [NSUserDefaults yn_setObject:dic[@"access_token"] forKey:PTAlexaAccessToken];
//                [NSUserDefaults yn_setObject:dic[@"refresh_token"] forKey:PTAlexaRefreshToken];
//                [NSUserDefaults yn_setObject:dic[@"token_type"] forKey:PTAlexaTokenType];
//                [NSUserDefaults yn_setObject:@"true" forKey:PTMusicService];
//                
//            
//                self.refreshToken = dic[@"refresh_token"];
//                //[self requestRefeshToken];
//                NSLog(@"write success dic = %@",dic);
//                
//                if (self.loginSuccess) {
//                    self.loginSuccess(self.user);
//                }
//
//            }
//        }];

        NSLog(@"repsonse dict = %@",dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",[error localizedDescription]);
    }];
    
}

- (void)requestRefeshToken{
    NSString *urlStr = @"https://api.amazon.com/auth/O2/token";
    
    NSDictionary *dict = @{@"grant_type":@"refresh_token",@"client_id":self.client_id,@"refresh_token":self.refreshToken};
    NSLog(@"refresh parameter = %@",dict);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:urlStr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog(@"refresh repsonse dict = %@",dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"refresh error = %@",[error localizedDescription]);
    }];

}




- (void)signOut{
    [[AMZNAuthorizationManager sharedManager] signOut:^(NSError * _Nullable error) {
        // Your additional logic after the user authorization state is cleared.
    }];
}


- (NSString *)generateTradeNO {
    static int kNumber = 43;
    
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (NSString *)resultString:(NSString *)baseUrl{
    
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i<baseUrl.length; i++) {
        NSString *substring = [baseUrl substringWithRange:NSMakeRange(i, 1)];
        if ([substring isEqualToString:@"="]) {
            continue;
        }else if([substring isEqualToString:@"+"]){
            substring = @"-";
        }else if ([substring isEqualToString:@"/"]){
            substring = @"_";
        }
        [resultString appendString:substring];
    }
    
    NSLog(@"base url = %@ result url = %@",baseUrl,resultString);
    return resultString;
}

@end
