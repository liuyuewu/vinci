//
//  UITextField+History.m
//  Demo
//
//  Created by DamonDing on 15/5/26.
//  Copyright (c) 2015年 morenotepad. All rights reserved.
//

#import "UITextField+YNHistory.h"
#import <objc/runtime.h>

#define yn_history_X(view) (view.frame.origin.x)
#define yn_history_Y(view) (view.frame.origin.y)
#define yn_history_W(view) (view.frame.size.width)
#define yn_history_H(view) (view.frame.size.height)

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryviewIdentifyKey;

#define YN_ANIMATION_DURATION 0.3f
#define YN_ITEM_HEIGHT 40
#define YN_CLEAR_BUTTON_HEIGHT 45
#define YN_MAX_HEIGHT 300


@interface UITextField ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *yn_historyTableView;

@end


@implementation UITextField (YNHistory)

- (NSString*)yn_identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (void)setYn_identify:(NSString *)identify {
    objc_setAssociatedObject(self, &kTextFieldIdentifyKey, identify, OBJC_ASSOCIATION_RETAIN);
}

- (UITableView*)yn_historyTableView {
    UITableView* table = objc_getAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey);
    
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        table.layer.borderColor = [UIColor grayColor].CGColor;
        table.layer.borderWidth = 1;
        table.delegate = self;
        table.dataSource = self;
        objc_setAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey, table, OBJC_ASSOCIATION_RETAIN);
    }
    
    return table;
}

- (NSArray*)yn_loadHistroy {
    if (self.yn_identify == nil) {
        return nil;
    }

    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+ynHistory"];
    
    if (dic != nil) {
        return [dic objectForKey:self.yn_identify];
    }

    return nil;
}

- (void)yn_synchronize {
    if (self.yn_identify == nil || [self.text length] == 0) {
        return;
    }
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+ynHistory"];
    NSArray* history = [dic objectForKey:self.yn_identify];
    
    NSMutableArray* newHistory = [NSMutableArray arrayWithArray:history];
    
    __block BOOL haveSameRecord = false;
    __weak typeof(self) weakSelf = self;
    
    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString*)obj isEqualToString:weakSelf.text]) {
            *stop = true;
            haveSameRecord = true;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [newHistory addObject:self.text];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:newHistory forKey:self.yn_identify];
    
    [def setObject:dic2 forKey:@"UITextField+ynHistory"];
    
    [def synchronize];
}

- (void) yn_showHistory; {
    NSArray* history = [self yn_loadHistroy];
    
    if (self.yn_historyTableView.superview != nil || history == nil || history.count == 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(yn_history_X(self), yn_history_Y(self) + yn_history_H(self) + 1, yn_history_W(self), 1);
    CGRect frame2 = CGRectMake(yn_history_X(self), yn_history_Y(self) + yn_history_H(self) + 1, yn_history_W(self), MIN(YN_MAX_HEIGHT, YN_ITEM_HEIGHT * history.count + YN_CLEAR_BUTTON_HEIGHT));
    
    self.yn_historyTableView.frame = frame1;
    
    [self.superview addSubview:self.yn_historyTableView];
    
    [UIView animateWithDuration:YN_ANIMATION_DURATION animations:^{
        self.yn_historyTableView.frame = frame2;
    }];
}

- (void) yn_clearHistoryButtonClick:(UIButton*) button {
    [self yn_clearHistory];
    [self yn_hideHistroy];
}

- (void)yn_hideHistroy; {
    if (self.yn_historyTableView.superview == nil) {
        return;
    }

    CGRect frame1 = CGRectMake(yn_history_X(self), yn_history_Y(self) + yn_history_H(self) + 1, yn_history_W(self), 1);
    
    [UIView animateWithDuration:YN_ANIMATION_DURATION animations:^{
        self.yn_historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.yn_historyTableView removeFromSuperview];
    }];
}

- (void) yn_clearHistory; {
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:nil forKey:@"UITextField+ynHistory"];
    [def synchronize];
}


#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return [self yn_loadHistroy].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
    }
    
    cell.textLabel.text = [self yn_loadHistroy][indexPath.row];
    
    return cell;
}
#pragma clang diagnostic pop


#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section; {
    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(yn_clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
    return YN_ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return YN_CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    self.text = [self yn_loadHistroy][indexPath.row];
    [self yn_hideHistroy];
}

@end
