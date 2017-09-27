//
//  NSString+RichText.h
//  Panda
//
//  Created by 王阳 on 2017/4/30.
//  Copyright © 2017年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RichText)

+ (NSMutableAttributedString *)changeHtmlStringToAttributeString:(NSString *)htmlString;

@end
