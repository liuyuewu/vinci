//
//  UIView+Shake.m
//  UIView+Shake
//
//  Created by Andrea Mazzini on 08/02/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "UIView+YNShake.h"

@implementation UIView (YNShake)

- (void)yn_shake {
    [self _yn_shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:YNShakeDirectionHorizontal completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:YNShakeDirectionHorizontal completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)())handler {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:YNShakeDirectionHorizontal completion:handler];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:YNShakeDirectionHorizontal completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)())handler {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:YNShakeDirectionHorizontal completion:handler];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(YNShakeDirection)shakeDirection {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)yn_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(YNShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self _yn_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_yn_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(YNShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == YNShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
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
          completion:completionHandler];
    }];
}

@end
