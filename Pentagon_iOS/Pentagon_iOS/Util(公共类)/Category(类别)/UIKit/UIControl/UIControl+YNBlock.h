//
//  UIControl+ynBlock.h
//  FXCategories
//
//  Created by fox softer on 15/2/23.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//  https://github.com/foxsofter/FXCategories
//  http://stackoverflow.com/questions/2437875/target-action-uicontrolevents
#import <UIKit/UIKit.h>

@interface UIControl (YNBlock)

- (void)yn_touchDown:(void (^)(void))eventBlock;
- (void)yn_touchDownRepeat:(void (^)(void))eventBlock;
- (void)yn_touchDragInside:(void (^)(void))eventBlock;
- (void)yn_touchDragOutside:(void (^)(void))eventBlock;
- (void)yn_touchDragEnter:(void (^)(void))eventBlock;
- (void)yn_touchDragExit:(void (^)(void))eventBlock;
- (void)yn_touchUpInside:(void (^)(void))eventBlock;
- (void)yn_touchUpOutside:(void (^)(void))eventBlock;
- (void)yn_touchCancel:(void (^)(void))eventBlock;
- (void)yn_valueChanged:(void (^)(void))eventBlock;
- (void)yn_editingDidBegin:(void (^)(void))eventBlock;
- (void)yn_editingChanged:(void (^)(void))eventBlock;
- (void)yn_editingDidEnd:(void (^)(void))eventBlock;
- (void)yn_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
