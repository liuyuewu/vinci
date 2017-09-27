//
//  NSString+RichText.m
//  Panda
//
//  Created by 王阳 on 2017/4/30.
//  Copyright © 2017年 王阳. All rights reserved.
//

#import "NSString+RichText.h"

@implementation NSString (RichText)

+ (NSMutableAttributedString *)changeHtmlStringToAttributeString:(NSString *)htmlString{
    
    NSString *newString = htmlString;
    //图片自适应宽高，只限制图片的最大显示宽度，这样就能做到自适应
    
    NSData *data = [newString dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSMutableAttributedString *htmlAttribute = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = SP(5); // 调整行间距
//    [htmlAttribute addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName : K_Font_03,NSKernAttributeName:@1.0f,NSForegroundColorAttributeName:K_Color_05} range:NSMakeRange(0, htmlAttribute.length)];
    
    [htmlAttribute enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, htmlAttribute.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        
        if ([value isKindOfClass:[NSTextAttachment class]]) {
            NSTextAttachment * attachment = value;
            CGFloat height = attachment.bounds.size.height;
            CGFloat width = attachment.bounds.size.width;
            CGFloat sp = height/width;
            attachment.bounds = CGRectMake(0, 0, __SCREEN_WIDTH-20, sp*(__SCREEN_WIDTH - 20));
        }
        
    }];
    return htmlAttribute;
    
}


@end
