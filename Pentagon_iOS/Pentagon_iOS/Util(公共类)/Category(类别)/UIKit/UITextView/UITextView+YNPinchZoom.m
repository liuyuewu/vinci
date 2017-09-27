//
//  UITextView+PinchZoom.m
//
//  Created by Stan Serebryakov <cfr@gmx.us> on 04.12.12.
//

#import "UITextView+YNPinchZoom.h"
#import "objc/runtime.h"

static int yn_minFontSizeKey;
static int yn_maxFontSizeKey;
static int yn_zoomEnabledKey;

@implementation UITextView (YNPinchZoom)

- (void)setYn_maxFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &yn_maxFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yn_maxFontSize
{
    return [objc_getAssociatedObject(self, &yn_maxFontSizeKey) floatValue];
}

- (void)setYn_minFontSize:(CGFloat)maxFontSize
{
    objc_setAssociatedObject(self, &yn_minFontSizeKey, [NSNumber numberWithFloat:maxFontSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yn_minFontSize
{
    return [objc_getAssociatedObject(self, &yn_minFontSizeKey) floatValue];
}

- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    if (!self.isYn_zoomEnabled) return;

    CGFloat pointSize = (gestureRecognizer.velocity > 0.0f ? 1.0f : -1.0f) + self.font.pointSize;

    pointSize = MAX(MIN(pointSize, self.yn_maxFontSize), self.yn_minFontSize);

    self.font = [UIFont fontWithName:self.font.fontName size:pointSize];
}


- (void)setYn_zoomEnabled:(BOOL)zoomEnabled
{
    objc_setAssociatedObject(self, &yn_zoomEnabledKey, [NSNumber numberWithBool:zoomEnabled],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (zoomEnabled) {
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) // initialized already
            if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) return;

        self.yn_minFontSize = self.yn_minFontSize ?: 8.0f;
        self.yn_maxFontSize = self.yn_maxFontSize ?: 42.0f;
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(pinchGesture:)];
        [self addGestureRecognizer:pinchRecognizer];
#if !__has_feature(objc_arc)
        [pinchRecognizer release];
#endif
    }
}

- (BOOL)isYn_zoomEnabled
{
    return [objc_getAssociatedObject(self, &yn_zoomEnabledKey) boolValue];
}

@end
