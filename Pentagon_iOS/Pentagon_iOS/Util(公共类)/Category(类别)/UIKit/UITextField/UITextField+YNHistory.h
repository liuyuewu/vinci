//
//  UITextField+History.h
//  Demo
//
//  Created by DamonDing on 15/5/26.
//  Copyright (c) 2015年 morenotepad. All rights reserved.
//
//  https://github.com/Jameson-zxm/UITextField-History
//   A category of UITextfiled that can record it's input as history

#import <UIKit/UIKit.h>

@interface UITextField (YNHistory)

/**
 *  identity of this textfield
 */
@property (retain, nonatomic) NSString *yn_identify;

/**
 *  load textfiled input history
 *
 *  @return the history of it's input
 */
- (NSArray*)yn_loadHistroy;

/**
 *  save current input text
 */
- (void)yn_synchronize;

- (void)yn_showHistory;
- (void)yn_hideHistroy;

- (void)yn_clearHistory;

@end
