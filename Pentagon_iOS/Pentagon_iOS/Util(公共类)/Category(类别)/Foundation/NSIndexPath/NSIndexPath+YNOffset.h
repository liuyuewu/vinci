//
//  NSIndexPath+Offset.h
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSIndexPath (YNOffset)
/**
 *  @author ynCategories
 *
 *  Compute previous row indexpath
 *
 */
- (NSIndexPath *)yn_previousRow;
/**
 *  @author ynCategories
 *
 *  Compute next row indexpath
 *
 */
- (NSIndexPath *)yn_nextRow;
/**
 *  @author ynCategories
 *
 *  Compute previous item indexpath
 *
 */
- (NSIndexPath *)yn_previousItem;
/**
 *  @author ynCategories
 *
 *  Compute next item indexpath
 *
 */
- (NSIndexPath *)yn_nextItem;
/**
 *  @author ynCategories
 *
 *  Compute next section indexpath
 *
 */
- (NSIndexPath *)yn_nextSection;
/**
 *  @author ynCategories
 *
 *  Compute previous section indexpath
 *
 */
- (NSIndexPath *)yn_previousSection;

@end
