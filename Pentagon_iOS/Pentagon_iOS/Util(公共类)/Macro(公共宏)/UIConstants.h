
//
//  Mrcro.h
//  HuoJianLiCai
//
//  Created by 王阳 on 16/5/6.
//  Copyright © 2016年 北京网融天下金融信息服务有限公司. All rights reserved.
//  UI设置宏定义类

//颜色转换
#define RGB(A, B, C)        [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 * UI颜色常量
 */

//透明色
#define K_Color_Clear [UIColor clearColor]
//主色调，绿色
#define K_Color_01 UIColorFromRGB(0x2fbe6a)
//辅助色，hover
#define K_Color_02 UIColorFromRGB(0xf9f9f9)
//辅助色，分界线
#define K_Color_03 UIColorFromRGB(0xdddddd)
//用于标题文字，主要性文字
#define K_Color_04 UIColorFromRGB(0x333333)
//用于次要性文字
#define K_Color_05 UIColorFromRGB(0x666666)
//用于次要性文字
#define K_Color_06 UIColorFromRGB(0x999999)
//用于输入提示文字
#define K_Color_07 UIColorFromRGB(0xd3d2d2)
//用于分割线、图标不选中状态
#define K_Color_08 UIColorFromRGB(0xe5e5e5)
//用于反白文字，按钮上的文字
#define K_Color_09 UIColorFromRGB(0xffffff)
//用于页面背景
#define K_Color_10 UIColorFromRGB(0xf3f3f3)
//placeholder颜色
#define K_Color_11 UIColorFromRGB(0x4a4a4a)
//底部tab按下颜色
#define K_Color_Selected UIColorFromRGB(0x1f1f1f)
//底部tab正常颜色
//#define K_Color_Normal UIColorFromRGB(0x262626)
//纯黑
#define k_Color_Black UIColorFromRGB(0x000000)


//Pentagon颜色
#define k_Color_Background UIColorFromRGB(0x0A001E)
#define k_Color_Foreground UIColorFromRGB(0x13072C)
#define k_Color_Title UIColorFromRGB(0xD9D9D9)
#define k_Color_SubTitle UIColorFromRGB(0x827F8A)
#define k_Color_Normal UIColorFromRGB(0x7365FF)
#define k_Color_HighLighted UIColorFromRGB(0x8C8DFC)
#define k_Color_Disable UIColorFromRGB(0x666666)
/**
 *  UI字体常量
 */

//导航栏题目、按钮上的文字
#define K_Font_01 [UIFont systemFontOfSize:SP(24/2)]
//标题
#define K_Font_02 [UIFont systemFontOfSize:SP(26/2)]
//正文
#define K_Font_03 [UIFont systemFontOfSize:SP(28/2)]
//注释
#define K_Font_04 [UIFont systemFontOfSize:SP(30/2)]
//导航栏
#define K_Font_05 [UIFont systemFontOfSize:SP(32/2)]

#define K_Font_06 [UIFont systemFontOfSize:SP(34/2)]

/**
 * 布局常量
 */

//卡片间距
#define K_Card_Spacing (26/3)
//卡片高度-指单行文字内容的卡片或文字输入框
#define K_Card_Height (190/3)
//页面边距
#define K_Page_Edge (99/3)
