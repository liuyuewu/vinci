//
//  PTWifiCell.m
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTWifiCell.h"

@interface PTWifiCell ()

@property (strong, nonatomic) UILabel *wifiNameLabel;
@property (strong, nonatomic) UIImageView *wifiImageView;

@end

@implementation PTWifiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.wifiImageView];
        [self.contentView addSubview:self.wifiNameLabel];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.wifiNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(8);
    }];
    
    [self.wifiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-8);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(15);
    }];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.contentView.bounds];
    [path stroke];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = K_Color_Clear.CGColor;
    layer.strokeColor = UIColorFromRGB(0xdddddd).CGColor;
    layer.path = path.CGPath;
    [self.contentView.layer addSublayer:layer];
}


- (UILabel *)wifiNameLabel{
    if (!_wifiNameLabel) {
        _wifiNameLabel = [[UILabel alloc]init];
        _wifiNameLabel.font = [UIFont systemFontOfSize:14];
        _wifiNameLabel.textColor = UIColorFromRGB(0x4a4a4a);
        _wifiNameLabel.text = @"vinci-pub";
    }
    return _wifiNameLabel;
}

- (UIImageView *)wifiImageView{
    if (!_wifiImageView) {
        _wifiImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wifi_icon"]];
    }
    return _wifiImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
