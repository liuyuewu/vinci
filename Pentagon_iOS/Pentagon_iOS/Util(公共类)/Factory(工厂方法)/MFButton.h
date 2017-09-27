//
//  MFButton.h
//  MrFan
//
//  Created by 武建明 on 16/4/7.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ///默认  左边图  右边文字 (可不写)
    buttonTypeNormal,
    ///图片在上面 文字在下面
    buttonTypePicTop,
    /// 图片在右边 文字在左边
    buttonTypePicRight,
    ///文字在上面  图片在下面
    buttonTypePictBottom
} ButtonType;

typedef enum : NSUInteger {
    ///默认   (可不写)
    buttonAlignWithNormal,
    ///以图片为基准进行调整距离边缘的位置
    buttonAlignWithPic,
    //以文字为基准进行调整距离边缘的位置
    buttonAlignWithTitle
} ButtonAlignType;  //图文排版(只做了图文左右排列的支持  上下排列的整体位置调整 后期加)

@interface MFButton : UIButton

@property (nonatomic,assign) ButtonType type;

@property (nonatomic,assign) ButtonAlignType alignType;

///图片文字之间的间距
@property (nonatomic,assign) NSInteger picTileRange;

///以图片为基准,设置图片距离边缘的位置
@property (nonatomic,assign) NSInteger picToViewRange;

@end
