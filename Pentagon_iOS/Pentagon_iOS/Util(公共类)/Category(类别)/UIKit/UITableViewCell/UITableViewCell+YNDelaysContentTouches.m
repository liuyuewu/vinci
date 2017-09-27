//
//  UITableViewCell+TS_delaysContentTouches.m
//  tableViewCellDelaysContentTouches
//
//  Created by Nicholas Hodapp on 1/31/14.
//  Copyright (c) 2014 Nicholas Hodapp. All rights reserved.
//

#import "UITableViewCell+ynDelaysContentTouches.h"

@implementation UITableViewCell (YNDelaysContentTouches)

- (UIScrollView*) yn_scrollView
{
    id sv = self.contentView.superview;
    while ( ![sv isKindOfClass: [UIScrollView class]] && sv != self )
    {
        sv = [sv superview];
    }
    
    return sv == self ? nil : sv;
}

- (void) setYn_delaysContentTouches:(BOOL)delaysContentTouches
{
    [self willChangeValueForKey: @"yn_delaysContentTouches"];
    
    [[self yn_scrollView] setDelaysContentTouches: delaysContentTouches];
    
    [self didChangeValueForKey: @"yn_delaysContentTouches"];
}

- (BOOL) yn_delaysContentTouches
{
    return [[self yn_scrollView] delaysContentTouches];
}



@end
