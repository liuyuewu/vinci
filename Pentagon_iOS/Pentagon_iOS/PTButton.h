//
//  PTButton.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/22.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PTButtonType){
    PTButtonAvailableType = 0,
    PTButtonDisableType,
};

@interface PTButton : UIButton

@property (assign, nonatomic) PTButtonType status;

@end
