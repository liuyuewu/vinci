//
//  PTBleTableViewCell.m
//  Pentagon_iOS
//
//  Created by Vinci on 2017/9/20.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBleTableViewCell.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface PTBleTableViewCell ()

@property (strong, nonatomic) UILabel *bleNameLabel;

@end

@implementation PTBleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBleInfo:(NSDictionary *)bleInfo{
    CBPeripheral *peripheral = [bleInfo objectForKey:@"peripheral"];
    NSDictionary *advertisementData = [bleInfo objectForKey:@"advertisementData"];
    NSNumber *RSSI = [bleInfo objectForKey:@"RSSI"];
    
    //peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
    NSString *peripheralName;
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        peripheralName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
    }else if(!([peripheral.name isEqualToString:@""] || peripheral.name == nil)){
        peripheralName = peripheral.name;
    }else{
        peripheralName = [peripheral.identifier UUIDString];
    }
    self.bleNameLabel.text = peripheralName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)bleNameLabel{
    if (!_bleNameLabel) {
        _bleNameLabel = [[UILabel alloc]init];
        _bleNameLabel.font = [UIFont systemFontOfSize:14];
        _bleNameLabel.textColor = UIColorFromRGB(0x4a4a4a);
        [self.contentView addSubview:_bleNameLabel];
        [_bleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(SP(15));
        }];
    }
    return _bleNameLabel;
}


@end
