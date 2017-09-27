//
//  PTSocketManager.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/26.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface PTSocketManager () <GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *clientSocket;

@end

@implementation PTSocketManager

+ (instancetype)shareManager{
    static PTSocketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PTSocketManager alloc]init];
        [manager initSocket];
    });
    return manager;
}

- (void)initSocket{
    self.clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}

//开始连接
- (BOOL)connectToHost:(NSString *)host onPort:(NSInteger)port{
    return [self.clientSocket connectToHost:host onPort:port withTimeout:-1 error:nil];
}

//断开连接
- (void)disConnect{
    [self.clientSocket disconnect];
}

//发送消息
- (void)sendMessageData:(NSString *)message{
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}

- (void)sendData:(NSData *)data :(NSString *)type
{
    NSUInteger size = data.length;
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    [headDic setObject:type forKey:@"type"];
    [headDic setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"size"];
    NSString *jsonStr = [self dictionaryToJson:headDic];
    
    
    NSData *lengthData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData *mData = [NSMutableData dataWithData:lengthData];
    //分界
    [mData appendData:[GCDAsyncSocket CRLFData]];
    
    [mData appendData:data];
    
    
    //第二个参数，请求超时时间
    [self.clientSocket writeData:mData withTimeout:-1 tag:110];
    
}

//字典转为Json字符串
- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//接收消息
- (void)receivceMessage{
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

//监听最新的消息
- (void)pullTheMsg
{
    //貌似是分段读数据的方法
    //    [gcdSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:10 maxLength:50000 tag:110];
    
    //监听读数据的代理，只能监听10秒，10秒过后调用代理方法  -1永远监听，不超时，但是只收一次消息，
    //所以每次接受到消息还得调用一次
    [self.clientSocket readDataWithTimeout:-1 tag:110];
    
}

//用Pingpong机制来看是否有反馈
- (void)checkPingPong
{
    //pingpong设置为3秒，如果3秒内没得到反馈就会自动断开连接
    [self.clientSocket readDataWithTimeout:3 tag:110];
    
}


#pragma mark - GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"连接成功，host:%@ port:%d",host,port);
    [self pullTheMsg];
    [sock startTLS:nil];
    //心跳写在这
}

//断开连接的时候调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);
    
    //断线重连写在这...
    
}


//写的回调
- (void)socket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"写的回调,tag:%ld",tag);
    //判断是否成功发送，如果没收到响应，则说明连接断了，则想办法重连
    [self pullTheMsg];
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
    
    [self pullTheMsg];
}

//Unix domain socket
//- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url
//{
//    NSLog(@"connect:%@",[url absoluteString]);
//}

//    //看能不能读到这条消息发送成功的回调消息，如果2秒内没收到，则断开连接
//    [gcdSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:2 maxLength:50000 tag:110];

//貌似触发点
- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    
    NSLog(@"读的回调,length:%ld,tag:%ld",partialLength,tag);
    
}

//为上一次设置的读取数据代理续时 (如果设置超时为-1，则永远不会调用到)
//-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
//{
//    NSLog(@"来延时，tag:%ld,elapsed:%f,length:%ld",tag,elapsed,length);
//    return 10;
//}

@end
