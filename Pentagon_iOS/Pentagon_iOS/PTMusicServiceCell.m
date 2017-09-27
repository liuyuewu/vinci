//
//  PTMusicServiceCell.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/24.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTMusicServiceCell.h"
#import "PTMusicSeriveModel.h"

@interface PTMusicServiceCell ()

@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UIButton *button;

@end

@implementation PTMusicServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0x13072C);
        [self.contentView addSubview:self.selectImageView];
        [self.contentView addSubview:self.serviceNameLabel];
        [self.contentView addSubview:self.deviceNameLabel];
        [self.contentView addSubview:self.rightImageView];
        [self.contentView addSubview:self.button];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)setModel:(PTMusicSeriveModel *)model{
    _model = model;
    self.serviceNameLabel.text = model.name;
    self.selectImageView.hidden = !model.login;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SP(20));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.width.mas_equalTo(75);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.serviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.selectImageView.mas_right).offset(SP(23));
    }];
    
    [self.deviceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-SP(75));
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}

- (void)buttonClick{
    if (self.selectBlock) {
        self.selectBlock();
    }

}

#pragma mark - Property

- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]init];
        _selectImageView.contentMode = UIViewContentModeScaleAspectFit;
        _selectImageView.image = [UIImage imageNamed:@"icon_sel"];
        _selectImageView.userInteractionEnabled = YES;

    }
    return _selectImageView;
}

- (UILabel *)serviceNameLabel{
    if (!_serviceNameLabel) {
        _serviceNameLabel = [[UILabel alloc]init];
        _serviceNameLabel.font = [UIFont systemFontOfSize:16];
        _serviceNameLabel.textColor = k_Color_Title;
    }
    return _serviceNameLabel;
}

- (UILabel *)deviceNameLabel{
    if (!_deviceNameLabel) {
        _deviceNameLabel = [[UILabel alloc]init];
        _deviceNameLabel.font = [UIFont systemFontOfSize:16];
        _deviceNameLabel.textColor = k_Color_Title;
    }
    return _deviceNameLabel;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_next"]];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
