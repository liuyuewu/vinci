//
//  PTWebViewViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/27.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTWebViewViewController.h"
#import <AFNetworking.h>
#import "SppProtocol.pbobjc.h"

@interface PTWebViewViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

#define SPOTIFY_AUTH @"https://accounts.spotify.com/en/authorize/"
#define SPOTIFY_CLIENT_ID @"b18586f246a34236a6f4a80706c773d4"
#define SPOTIFY_CLIENT_SECRET @"33a6fda0327642439c99bcee7276ef89"
#define SPOTIFY_SOUNDCLOUD_REDIRECT_URL @"http://localhost:8000"
#define SPOTIFY_SCOPE @"playlist-read-collaborative user-library-read user-library-modify streaming playlist-read-private user-read-private"

#define SOUNDCLOUD_AUTH @"https://soundcloud.com/connect"
#define SOUNDCLOUD_CLIENT_ID @"6575e29a46af75e758e9da60538f0e94"

#define AMAZON_AUTH @"https://www.amazon.com/ap/oa"
#define AMAZON_CLIENT_ID @"amzn1.application-oa2-client.7b5df2a661c7449a86aaf83ab70d8552"
#define AMAZON_REDIRECT_URL @"https://localhost:4443"

@implementation PTWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self loadRequest];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading";
    // Do any additional setup after loading the view.
}

//请求授权，注意需要翻墙
- (void)loadRequest{
    NSURLRequest *request;
    if (self.type == MusicServiceTypeSpotify) {
        //请求登录spotify，网址中scope中带有空格，所有只有scope需要进行编码
        NSString *scope = [SPOTIFY_SCOPE stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&redirect_uri=%@&scope=%@&state=34fFs29kd09",SPOTIFY_AUTH,SPOTIFY_CLIENT_ID,SPOTIFY_SOUNDCLOUD_REDIRECT_URL,scope];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    }else if (self.type == MusicServiceTypeSoundCloud){
        //请求soundCloud时无需编码，没有特殊符号
        NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&response_type=code&redirect_uri=%@&display=popup",SOUNDCLOUD_AUTH,SOUNDCLOUD_CLIENT_ID,SPOTIFY_SOUNDCLOUD_REDIRECT_URL];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    }else{
        //参数中包含有json，所以必须要进行处理
        NSString *scope_dataStr = [NSString stringWithFormat:@"{\"alexa:all\":{\"productID\":\"test\",\"productInstanceAttributes\":{\"deviceSerialNumber\": \"deviceSerialNumber\"}}}"];
        NSString *encodeScope_data = [scope_dataStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //参数中有":"，需要先进行转码
        NSString *scope = @"alexa:all";
        NSString *encodeScope = [scope stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&scope=%@&scope_data=%@&response_type=code&redirect_uri=%@",AMAZON_AUTH,AMAZON_CLIENT_ID,encodeScope,encodeScope_data,AMAZON_REDIRECT_URL];
        //    NSLog(@"-------------%@",[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        NSURL *url = [NSURL URLWithString:urlStr];
        //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0];
    }
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
//    NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    NSLog(@"finish");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"error = %@",[error localizedDescription]);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"request url = %@",request.URL.absoluteString);
    if (self.type == MusicServiceTypeSpotify) {
        if ([request.URL.absoluteString hasPrefix:SPOTIFY_SOUNDCLOUD_REDIRECT_URL]) {
            [self decodeUrlWithType:Request_RequestType_Spotify urlQueryStr:request.URL.query];
        }
    }else if (self.type == MusicServiceTypeSoundCloud) {
        if ([request.URL.absoluteString hasPrefix:SPOTIFY_SOUNDCLOUD_REDIRECT_URL]) {
            [self decodeUrlWithType:Request_RequestType_Soundcolud urlQueryStr:request.URL.query];
        }
    }else {
        if ([request.URL.absoluteString hasPrefix:AMAZON_REDIRECT_URL]) {
            [self decodeUrlWithType:Request_RequestType_Alexa urlQueryStr:request.URL.query];
        }
    }
    return YES;
}
- (void)decodeUrlWithType:(Request_RequestType)type urlQueryStr:(NSString *)query{
    NSArray *array = [query componentsSeparatedByString:@"&"];
    for (NSString *element in array) {
        if ([element hasPrefix:@"code"]) {
            NSArray *subArray = [element componentsSeparatedByString:@"="];
            NSString *code = subArray[1];
            if (code) {
                [self.navigationController popViewControllerAnimated:YES];
                Request *r = [[Request alloc] init];
                r.type = type;
                r.code = code;
                if (self.loginService) {
                    self.loginService(r, self.type);
                }
            }
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PDBabyBlueToothNofification object:nil];
}
#pragma mark - Property

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, __NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH, __SCREEN_HEIGHT - __NAVIGATION_BAR_HEIGHT)];
        _webView.delegate = self;
    }
    return _webView;
}

@end
