//
//  PTSocketManager.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/26.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTSocketManager : NSObject

+ (instancetype)shareManager;

//连接
- (BOOL)connectToHost:(NSString *)host onPort:(NSInteger)port;

//断开连接
- (void)disConnect;

//发送消息
- (void)sendMessageData:(NSString *)message;

//接收消息
- (void)receivceMessage;

@end
