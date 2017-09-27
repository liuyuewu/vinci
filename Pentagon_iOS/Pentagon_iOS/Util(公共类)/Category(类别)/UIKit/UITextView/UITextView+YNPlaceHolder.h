//
//  UITextView+PlaceHolder.h
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextView (YNPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *yn_placeHolderTextView;
//@property (nonatomic, assign) id <UITextViewDelegate> textViewDelegate;
- (void)yn_addPlaceHolder:(NSString *)placeHolder;

@end
