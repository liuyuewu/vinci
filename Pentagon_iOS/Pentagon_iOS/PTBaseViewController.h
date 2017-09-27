//
//  PTBaseViewController.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTBaseViewController : UIViewController

/**
 *  自定义导航栏
 */
@property (strong, nonatomic) UIView *customNav;
/**
 *  标题label
 */
@property (strong, nonatomic) UILabel *titleLabel;
/**
 *  左侧button 默认hidden为NO
 */
@property (strong, nonatomic) UIButton *leftButton;
/**
 *  左侧button数组
 */
@property (strong, nonatomic) NSArray *leftButtonItems;
/**
 *  右侧button
 */
@property (strong, nonatomic) UIButton *rightButton;
/**
 *  右侧button数组
 */
@property (strong, nonatomic) NSArray *rightButtonItems;
/**
 *  返回模态,YES为dismiss/NO为pop 默认为NO
 */
@property (assign, nonatomic) BOOL isModal;
/**
 *  是否展示底部分割线,YES显示/NO不显示 默认为NO
 */
@property (assign, nonatomic) BOOL isShowBottomSeperatorLine;

- (void)removeController;
- (void)leftClick;
- (void)rightClick;

- (void)removeAllKey;

@end
