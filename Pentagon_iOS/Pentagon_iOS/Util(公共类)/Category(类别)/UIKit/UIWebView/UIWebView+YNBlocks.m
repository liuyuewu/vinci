//
//  UIWebView+Blocks.m
//
//  Created by Shai Mishali on 1/1/13.
//  Copyright (c) 2013 Shai Mishali. All rights reserved.
//

#import "UIWebView+ynBlocks.h"

static void (^__yn_loadedBlock)(UIWebView *webView);
static void (^__yn_failureBlock)(UIWebView *webView, NSError *error);
static void (^__yn_loadStartedBlock)(UIWebView *webView);
static BOOL (^__yn_shouldLoadBlock)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType);

static uint __yn_loadedWebItems;

@implementation UIWebView (YNBlock)

#pragma mark - UIWebView+Blocks

+(UIWebView *)yn_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{

    return [self yn_loadRequest:request loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+(UIWebView *)yn_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *webView))loadedBlock
                      failed:(void (^)(UIWebView *webView, NSError *error))failureBlock{
    
    return [self yn_loadHTMLString:htmlString loaded:loadedBlock failed:failureBlock loadStarted:nil shouldLoad:nil];
}

+(UIWebView *)yn_loadHTMLString:(NSString *)htmlString
                      loaded:(void (^)(UIWebView *))loadedBlock
                      failed:(void (^)(UIWebView *, NSError *))failureBlock
                 loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
                  shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __yn_loadedWebItems = 0;
    __yn_loadedBlock = loadedBlock;
    __yn_failureBlock = failureBlock;
    __yn_loadStartedBlock = loadStartedBlock;
    __yn_shouldLoadBlock = shouldLoadBlock;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = (id)[self class];
    [webView loadHTMLString:htmlString baseURL:nil];
    
    return webView;
}

+(UIWebView *)yn_loadRequest:(NSURLRequest *)request
                   loaded:(void (^)(UIWebView *webView))loadedBlock
                   failed:(void (^)(UIWebView *webView, NSError *error))failureBlock
              loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
               shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock{
    __yn_loadedWebItems    = 0;
    
    __yn_loadedBlock       = loadedBlock;
    __yn_failureBlock      = failureBlock;
    __yn_loadStartedBlock  = loadStartedBlock;
    __yn_shouldLoadBlock   = shouldLoadBlock;
    
    UIWebView *webView  = [[UIWebView alloc] init];
    webView.delegate    = (id) [self class];
    
    [webView loadRequest: request];
    
    return webView;
}

#pragma mark - Private Static delegate
+(void)webViewDidFinishLoad:(UIWebView *)webView{
    __yn_loadedWebItems--;
    
    if(__yn_loadedBlock && (!TRUE_END_REPORT || __yn_loadedWebItems == 0)){
        __yn_loadedWebItems = 0;
        __yn_loadedBlock(webView);
    }
}

+(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{    
    __yn_loadedWebItems--;
    
    if(__yn_failureBlock)
        __yn_failureBlock(webView, error);
}

+(void)webViewDidStartLoad:(UIWebView *)webView{    
    __yn_loadedWebItems++;
    
    if(__yn_loadStartedBlock && (!TRUE_END_REPORT || __yn_loadedWebItems > 0))
        __yn_loadStartedBlock(webView);
}

+(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if(__yn_shouldLoadBlock)
        return __yn_shouldLoadBlock(webView, request, navigationType);
    
    return YES;
}

@end
