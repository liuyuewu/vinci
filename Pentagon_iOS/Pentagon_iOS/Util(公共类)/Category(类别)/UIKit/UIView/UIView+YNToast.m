//
//  UIView+Toast.m
//  Toast
//
//  Copyright 2014 Charles Scalesse.
//


#import "UIView+YNToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat YNToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat YNToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat YNToastHorizontalPadding   = 10.0;
static const CGFloat YNToastVerticalPadding     = 10.0;
static const CGFloat YNToastCornerRadius        = 10.0;
static const CGFloat YNToastOpacity             = 0.8;
static const CGFloat YNToastFontSize            = 16.0;
static const CGFloat YNToastMaxTitleLines       = 0;
static const CGFloat YNToastMaxMessageLines     = 0;
static const NSTimeInterval YNToastFadeDuration = 0.2;

// shadow appearance
static const CGFloat YNToastShadowOpacity       = 0.8;
static const CGFloat YNToastShadowRadius        = 6.0;
static const CGSize  YNToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    YNToastDisplayShadow       = YES;

// display duration
static const NSTimeInterval YNToastDefaultDuration  = 3.0;

// image view size
static const CGFloat YNToastImageViewWidth      = 80.0;
static const CGFloat YNToastImageViewHeight     = 80.0;

// activity
static const CGFloat YNToastActivityWidth       = 100.0;
static const CGFloat YNToastActivityHeight      = 100.0;
static const NSString * YNToastActivityDefaultPosition = @"center";

// interaction
static const BOOL ynToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * YNToastTimerKey         = @"ynToastTimerKey";
static const NSString * YNToastActivityViewKey  = @"ynToastActivityViewKey";
static const NSString * YNToastTapCallbackKey   = @"ynToastTapCallbackKey";

// positions
NSString * const YNToastPositionTop             = @"top";
NSString * const YNToastPositionCenter          = @"center";
NSString * const YNToastPositionBottom          = @"bottom";

@interface UIView (ynToastPrivate)

- (void)yn_hideToast:(UIView *)toast;
- (void)yn_toastTimerDidFinish:(NSTimer *)timer;
- (void)yn_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)yn_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)yn_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)yn_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


@implementation UIView (YNToast)

#pragma mark - Toast Methods

- (void)yn_makeToast:(NSString *)message {
    [self yn_makeToast:message duration:YNToastDefaultDuration position:nil];
}

- (void)yn_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    UIView *toast = [self yn_viewForMessage:message title:nil image:nil];
    [self yn_showToast:toast duration:duration position:position];
}

- (void)yn_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    UIView *toast = [self yn_viewForMessage:message title:title image:nil];
    [self yn_showToast:toast duration:duration position:position];
}

- (void)yn_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    UIView *toast = [self yn_viewForMessage:message title:nil image:image];
    [self yn_showToast:toast duration:duration position:position];
}

- (void)yn_makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self yn_viewForMessage:message title:title image:image];
    [self yn_showToast:toast duration:duration position:position];
}

- (void)yn_showToast:(UIView *)toast {
    [self yn_showToast:toast duration:YNToastDefaultDuration position:nil];
}


- (void)yn_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self yn_showToast:toast duration:duration position:position tapCallback:nil];
    
}


- (void)yn_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
    toast.center = [self yn_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (ynToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(yn_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:YNToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(yn_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &YNToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &YNToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}


- (void)yn_hideToast:(UIView *)toast {
    [UIView animateWithDuration:YNToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)yn_toastTimerDidFinish:(NSTimer *)timer {
    [self yn_hideToast:(UIView *)timer.userInfo];
}

- (void)yn_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &YNToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &YNToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self yn_hideToast:recognizer.view];
}

#pragma mark - Toast Activity Methods

- (void)yn_makeToastActivity {
    [self yn_makeToastActivity:YNToastActivityDefaultPosition];
}

- (void)yn_makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &YNToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YNToastActivityWidth, YNToastActivityHeight)];
    activityView.center = [self yn_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:YNToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = YNToastCornerRadius;
    
    if (YNToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = YNToastShadowOpacity;
        activityView.layer.shadowRadius = YNToastShadowRadius;
        activityView.layer.shadowOffset = YNToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &YNToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:YNToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)yn_hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &YNToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:YNToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &YNToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)yn_centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:YNToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + YNToastVerticalPadding);
        } else if([point caseInsensitiveCompare:YNToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - YNToastVerticalPadding);
}

- (CGSize)yn_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}

- (UIView *)yn_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;

    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = YNToastCornerRadius;
    
    if (YNToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = YNToastShadowOpacity;
        wrapperView.layer.shadowRadius = YNToastShadowRadius;
        wrapperView.layer.shadowOffset = YNToastShadowOffset;
    }

    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:YNToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(YNToastHorizontalPadding, YNToastVerticalPadding, YNToastImageViewWidth, YNToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = YNToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = YNToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:YNToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * YNToastMaxWidth) - imageWidth, self.bounds.size.height * YNToastMaxHeight);
        CGSize expectedSizeTitle = [self yn_sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = YNToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:YNToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * YNToastMaxWidth) - imageWidth, self.bounds.size.height * YNToastMaxHeight);
        CGSize expectedSizeMessage = [self yn_sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = YNToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + YNToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;

    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + YNToastHorizontalPadding;
        messageTop = titleTop + titleHeight + YNToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }

    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (YNToastHorizontalPadding * 2)), (longerLeft + longerWidth + YNToastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + YNToastVerticalPadding), (imageHeight + (YNToastVerticalPadding * 2)));
                         
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
        
    return wrapperView;
}

@end
