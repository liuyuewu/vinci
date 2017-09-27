//
//  UIView+ynConstraints.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIView+YNConstraints.h"

@implementation UIView (YNConstraints)
-(NSLayoutConstraint *)yn_constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (NSLayoutConstraint *)yn_leftConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeLeft];
}

- (NSLayoutConstraint *)yn_rightConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeRight];
}

- (NSLayoutConstraint *)yn_topConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)yn_bottomConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)yn_leadingConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)yn_trailingConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)yn_widthConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)yn_heightConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)yn_centerXConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)yn_centerYConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)yn_baseLineConstraint {
    return [self yn_constraintForAttribute:NSLayoutAttributeBaseline];
}
@end
