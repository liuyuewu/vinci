
//
//  Mrcro.h
//  HuoJianLiCai
//
//  Created by 王阳 on 16/5/6.
//  Copyright © 2016年 北京网融天下金融信息服务有限公司. All rights reserved.
//  app常用宏定义类

#ifdef DEBUG

//#define BaseURL @"http://xiongmao.ibangoo.com/"
#define BaseURL @"http://zuxiongmao.ibangoo.com/"
#define debugLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define BaseURL @"http://xiongmao.ibangoo.com/"

#define debugLog(format, ...)
#endif

/************************* 第三方参数 *************************/

//百度地图
#define BAIDU_MAP_KEY @"GZNGOxYewFofgeMgGHNCLUqMn9RhgTAE"
#define BAIDU_MAP_SAFEKEY @"panda"

//新浪key
#define SINA_APP_KEY @"1300033083"
#define SINA_APP_SECRET @"6d8db177035f7fef5c1dc3c8c5a6b555"

//微信key
#define WX_APP_KEY @"wx30257f28d17d4422"
#define WX_APP_SECRET @"8f676ca12bfbc94cd77a3ebc1e8c862e"

//QQkey
#define QQ_APP_KEY @"zPVyQEZTniaXvLkd"
#define QQ_APP_ID @"1105893697"

//友盟Key
#define UM_APP_KEY @"5898621d1c5dd064b7001fe1"

//极光Key
#define JPUSH_KEY @"707723bf6200752031a500d1"

/************************* 系统参数 *************************/
//UUID 不会保存到系统中，每次的值不同
#define DEIVCE_UUID [[NSUUID UUID] UUIDString]

//App沙盒目录
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//系统版本号
#define APP_BUNDLE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define DEVICE_VERSION [UIDevice currentDevice].systemVersion

/************************* 自定义参数 *************************/

//weak、strong对象
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

//window和Root
#define __KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]
#define __ROOT_VC [UIApplication sharedApplication].keyWindow.rootViewController

//渠道
#define __APP_PLATFROM @"APP Store"

//App相关参数
#define __STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define __NAVIGATION_BAR_HEIGHT (__STATUS_BAR_HEIGHT+44)
#define __TABBAR_HEIGHT 49
#define __SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define __SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//不同版本比例系数
#define PROPORTION __SCREEN_WIDTH/375.0f
#define SP(x) x*PROPORTION

//Token键值
#define __DEVICE_TOKEN @"DEVICE_TOKEN"
#define __PUSH_DEVICE_TOKEN @"PUSH_DEVICE_TOKEN"

#define __ACCESS_TOKEN  @"access_token"
#define __ACCESS_TOKEN_EXPIRE_TIME  @"access_token_expire_time"
#define __REFRESH_TOKEN  @"refresh_token"
#define __REFRESH_TOKEN_EXPIRE_TIME  @"refresh_token_expire_time"

#define __USER_INFO @"user_info"
#define __Store_Address @"StoreAdress"
#define __Store_Address_ID @"StoreAdressID"
#define __Store_Rooms_ID @"StoreRoomID"

/************************* app内部宏 *************************/
#define __market_shoplist @"__market_shoplist"


typedef NS_ENUM(NSInteger,MineOrderStatus){
    MineOrderStatusWhole = 0,
    MineOrderStatusWaitToPay = 1,
    MineOrderWaitToCommit = 2
};

typedef NS_ENUM(NSInteger,BonusType){
    BonusTypeEmpty = 0,
    BonusTypeRent = 1,
    BonusTypeSuperMarket = 2,
    BonusTypeBreakfast = 3,
    BonusTypeDinner = 4,
    BonusTypeMidNight = 5,
    BonusTypeWishClothes = 6,
    BonusTypeFruit = 7,
};

