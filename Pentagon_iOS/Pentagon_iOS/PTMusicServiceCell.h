//
//  PTMusicServiceCell.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTMusicSeriveModel;

@interface PTMusicServiceCell : UITableViewCell

@property (strong, nonatomic) UILabel *serviceNameLabel;
@property (strong, nonatomic) UILabel *deviceNameLabel;
@property (strong, nonatomic) UIImageView *selectImageView;

@property (strong, nonatomic) PTMusicSeriveModel *model;

@property (copy, nonatomic) void (^selectBlock)();

@end
