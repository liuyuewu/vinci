//
//  PTAuthenticWebViewController.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/27.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTAuthenticWebViewController.h"
#import <WebKit/WebKit.h>

#define CLIENT_ID @"5597d5b4f8654212aae614e9a7c57439"
#define CLIENT_SECRET @"f5aefd0444bb4810bdbf772c17dc107a"
#define REDIRECT_URL @"http://localhost:8000"
#define SCOPE @"user-read-private user-read-email"

@interface PTAuthenticWebViewController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation PTAuthenticWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"Spotify Authentic";
    [self.view addSubview:self.webView];
    
    [self loadRequest];
    // Do any additional setup after loading the view.
}

- (void)loadRequest{
    NSString *urlStr = @"https://accounts.spotify.com/en/authorize?client_id=5597d5b4f8654212aae614e9a7c57439&response_type=code&redirect_uri=http://localhost:8000&scope=user-read-private user-read-email&state=34fFs29kd09";
    
//    NSString *urlStr = [NSString stringWithFormat:@"https://accounts.spotify.com/authorize/?client_id=%@",CLIENT_ID];
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - WKNavigationDelegate
//页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"webview start");
}
//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"webview commit");
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"webview finish");
}
//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"error = %@",[error localizedDescription]);
}
//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"webview receive server redirect");
}
//在接收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"response director url = %@",navigationResponse.response.URL.absoluteString);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"Received event %@", message.body);
    NSString *version = [[UIDevice currentDevice] valueForKey:message.body];
    
    // Execute some JavaScript using the result
    NSString *exec_template = @"set_headline(\"received: %@\");";
    NSString *exec = [NSString stringWithFormat:exec_template, version];
    [_webView evaluateJavaScript:exec completionHandler:nil];
}

#pragma mark - WKUIDelegate
//警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"webview alert message = %@",message);

}


#pragma mark - Property

- (WKWebView *)webView{
    if (!_webView) {
//        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]
//                                                 init];
//        WKUserContentController *controller = [[WKUserContentController alloc]
//                                               init];
//        [controller addScriptMessageHandler:self name:@"observe"];
//        configuration.userContentController = controller;

        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, __NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH, __SCREEN_HEIGHT - __NAVIGATION_BAR_HEIGHT)];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
