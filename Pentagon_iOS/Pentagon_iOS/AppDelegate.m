//
//  AppDelegate.m
//  Pentagon_iOS
//
//  Created by vinci on 17/6/21.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "AppDelegate.h"

//base config
#import "PTBaseModel.h"
#import "PTWiFiHandler.h"

//view controller
#import "PTBeginConnectViewController.h"
#import "PTNavigationController.h"
#import "PTConnectViewController.h"

//firebase
#import <JQFMDB.h>
#import "PTWifiModel.h"
#import "UIViewController+Alerts.h"
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "PTLoadingViewController.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = K_Color_09;
    [self.window makeKeyWindow];

//    [FIRApp configure];
    
  
    
    
    //注册Firebase监听事件
//    self.ref = [[FIRDatabase database] reference];
    
//    [FIRDatabase setLoggingEnabled:true];

    NSString *uid = [NSUserDefaults yn_stringForKey:PTGoogleUIDKey];
    NSLog(@"uid = %@",uid);
    //[NSUserDefaults removeObjcFromDefaultWithKey:PTGoogleUIDKey];
    //设置rootViewController
    
    
//    NSString *headersetID = [NSUserDefaults yn_stringForKey:PTGoogleHeaderIDKey];
//    
//    NSArray *dataArr =  [[JQFMDB shareDatabase] jq_lookupTable:@"wifi" dicOrModel:[PTWifiModel class] whereFormat:[NSString stringWithFormat:@"where headsetID = '%@'",headersetID]];
//    
    
    
    
    
//    BOOL wifiCon = [NSUserDefaults yn_boolForKey:PTConnectWifiKey];
    
//    
//    if (wifiCon)
//    {
//        PTConnectViewController *VC = [[PTConnectViewController alloc]init];
//        
//        
//        nav = [[PTNavigationController alloc]initWithRootViewController:VC];
//
//        NSLog(@"本地有 wifi连接记录 ");
//        
//    }else
//    {
//        PTBeginConnectViewController *vc = [[PTBeginConnectViewController alloc]init];
//        
//        nav = [[PTNavigationController alloc]initWithRootViewController:vc];
//
//        NSLog(@"本地无 wifi连接记录");
//    }

//
    PTLoadingViewController *vc = [[PTLoadingViewController alloc]init];
    PTNavigationController *nav = [[PTNavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController= nav;
    // Override point for customization after application launch.
    
//    [self config];
    
    
    return YES;
}

//配置系统属性
- (void)config{
    
    //设置链接状态
//    [NSUserDefaults yn_setObject:@"false" forKey:PTConnectWifiKey];
//    [NSUserDefaults yn_setObject:@"false" forKey:PTMusicService];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTSpotifyAccessToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTAlexaAccessToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTSpotifyRefreshToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTAlexaRefreshToken];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTSpotifyTokenType];
//    [NSUserDefaults removeObjcFromDefaultWithKey:PTAlexaTokenType];
//    [NSUserDefaults removeObjcFromDefaultWithKey:@"selectMusicService"];
//    
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [PTBaseModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID" : @"id",
                     @"Desc" : @"desciption",
                     };
        }];
        
        //设置SVP的默认样式和属性
        
        //设置Toast的默认样式和属性
        [CSToastManager setQueueEnabled:NO];
        [CSToastManager setTapToDismissEnabled:NO];
        
    });
    
    //创建存储wifi信息数据库
    JQFMDB *db = [JQFMDB shareDatabase];
    BOOL isCreate = [db jq_createTable:@"wifi" dicOrModel:[[PTWifiModel alloc]init]];
    if (isCreate) {
        NSLog(@"table wifi create success");
    }else{
        NSLog(@"table wifi create success");
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSLog(@"SSID = %@",[PTWiFiHandler currentSSID]);
//    if ([[PTWiFiHandler currentSSID] hasPrefix:PTJudgeWiFiKey]) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"PTConnectedPentagonDeviceNotification" object:nil];
//    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (BOOL)application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation
{
    // Pass on the url to the SDK to parse authorization code from the url.
    
    BOOL isValidRedirectSignInURL =
    [AIMobileLib handleOpenURL:url sourceApplication:sourceApplication];
    if(!isValidRedirectSignInURL)
        return NO;
    
    // App may also want to handle url
    return YES;
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
