//
//  PTSearchWifiViewController.m
//  Pentagon_iOS
//
//  Created by Vinci on 2017/9/23.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTSearchWifiViewController.h"
#import "PTButton.h"
#import "PTWiFiHandler.h"

@interface PTSearchWifiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) PTButton *searchButton;

@end

@implementation PTSearchWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
//    [self getWifiList];
}
- (void)setupNavigation{
    self.titleLabel.text = @"Select Wifi";
    [self removeController];
    self.leftButton.hidden = YES;
}

- (void)getWifiList{
    [PTWiFiHandler getWifiList];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SP(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wificell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"wificell"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,__NAVIGATION_BAR_HEIGHT, __SCREEN_WIDTH, __SCREEN_HEIGHT - __NAVIGATION_BAR_HEIGHT - 44 - SP(22)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}



- (PTButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [PTButton buttonWithType:UIButtonTypeCustom];
        
        [_searchButton setTitle:@"Continue" forState:UIControlStateNormal];
        [_searchButton setTitle:@"Continue" forState:UIControlStateSelected];
        [_searchButton setTitle:@"Continue" forState:UIControlStateHighlighted];
        
        _searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _searchButton.enabled = YES;
        //        [_searchButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

@end
