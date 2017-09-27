//
//  UIWebView+JS.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/22.
//  Copyright (c) 2014年 duzixi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (YNJavaScript)

#pragma mark -
#pragma mark 获取网页中的数据
/// 获取某个标签的结点个数
- (int)yn_nodeCountOfTag:(NSString *)tag;
/// 获取当前页面URL
- (NSString *)yn_getCurrentURL;
/// 获取标题
- (NSString *)yn_getTitle;
/// 获取图片
- (NSArray *)yn_getImgs;
/// 获取当前页面所有链接
- (NSArray *)yn_getOnClicks;
#pragma mark -
#pragma mark 改变网页样式和行为
/// 改变背景颜色
- (void)yn_setBackgroundColor:(UIColor *)color;
/// 为所有图片添加点击事件(网页中有些图片添加无效)
- (void)yn_addClickEventOnImg;
/// 改变所有图像的宽度
- (void)yn_setImgWidth:(int)size;
/// 改变所有图像的高度
- (void)yn_setImgHeight:(int)size;
/// 改变指定标签的字体颜色
- (void)yn_setFontColor:(UIColor *) color withTag:(NSString *)tagName;
/// 改变指定标签的字体大小
- (void)yn_setFontSize:(int) size withTag:(NSString *)tagName;
@end
