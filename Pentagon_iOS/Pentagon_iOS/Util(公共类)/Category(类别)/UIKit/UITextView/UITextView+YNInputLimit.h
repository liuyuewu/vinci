//
//  UITextView+ynInputLimit.h
//  ynCategories-Demo
//
//  Created by runlin on 2016/11/29.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (YNInputLimit)
@property (assign, nonatomic)  NSInteger yn_maxLength;//if <=0, no limit
@end
