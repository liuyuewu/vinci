//
//  UIViewController+RecursiveDescription.h
//  HLiPad
//
//  Created by Richard Turton on 07/01/2013.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (YNRecursiveDescription)
/**
 *  @brief  视图层级
 *
 *  @return 视图层级字符串
 */
-(NSString*)yn_recursiveDescription;

@end
