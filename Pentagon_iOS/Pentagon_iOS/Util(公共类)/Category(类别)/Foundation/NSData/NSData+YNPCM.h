//
//  NSData+YNPCM.h
//  YNCommonProject
//
//  Created by 王阳 on 2016/12/5.
//  Copyright © 2016年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface NSData (YNPCM)

- (NSData *)yn_wavDataWithPCMFormat:(AudioStreamBasicDescription)PCMFormat;


@end
