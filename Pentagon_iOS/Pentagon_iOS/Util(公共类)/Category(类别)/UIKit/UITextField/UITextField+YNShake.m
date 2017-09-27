//
//  UITextField+Shake.m
//  UITextField+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UITextField+YNShake.h"

@implementation UITextField (YNShake)

- (void)yn_shake {
    [self yn_shake:10 withDelta:5 completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta {
    [self yn_shake:times withDelta:delta completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)())handler {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:YNShakedDirectionHorizontal completion:handler];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self yn_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)())handler {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:YNShakedDirectionHorizontal completion:handler];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(YNShakedDirection)shakeDirection {
    [self yn_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(YNShakedDirection)shakeDirection completion:(void(^)())handler {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)_yn_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(YNShakedDirection)shakeDirection completion:(void(^)())handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == YNShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self _yn_shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:handler];
    }];
}

@end
