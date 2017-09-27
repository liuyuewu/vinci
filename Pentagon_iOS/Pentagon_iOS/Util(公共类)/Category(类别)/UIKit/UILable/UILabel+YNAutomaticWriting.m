//
//  UILabel+AutomaticWriting.m
//  UILabel-AutomaticWriting
//
//  Created by alexruperez on 10/3/15.
//  Copyright (c) 2015 alexruperez. All rights reserved.
//

#import "UILabel+YNAutomaticWriting.h"
#import <objc/runtime.h>


NSTimeInterval const UILabelAWDefaultDuration = 0.4f;

unichar const UILabelAWDefaultCharacter = 124;

static inline void yn_AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static char kAutomaticWritingOperationQueueKey;
static char kAutomaticWritingEdgeInsetsKey;


@implementation UILabel (YNAutomaticWriting)

@dynamic yn_automaticWritingOperationQueue, yn_edgeInsets;

#pragma mark - Public Methods

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yn_AutomaticWritingSwizzleSelector([self class], @selector(textRectForBounds:limitedToNumberOfLines:), @selector(yn_automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        yn_AutomaticWritingSwizzleSelector([self class], @selector(drawTextInRect:), @selector(yn_drawAutomaticWritingTextInRect:));
    });
}

-(void)yn_drawAutomaticWritingTextInRect:(CGRect)rect
{
    [self yn_drawAutomaticWritingTextInRect:UIEdgeInsetsInsetRect(rect, self.yn_edgeInsets)];
}

- (CGRect)yn_automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [self yn_automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.yn_edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)setyn_edgeInsets:(UIEdgeInsets)edgeInsets
{
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)yn_edgeInsets
{
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    
    if (edgeInsetsValue)
    {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return edgeInsetsValue.UIEdgeInsetsValue;
}

- (void)setyn_automaticWritingOperationQueue:(NSOperationQueue *)automaticWritingOperationQueue
{
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)yn_automaticWritingOperationQueue
{
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, &kAutomaticWritingOperationQueueKey);
    
    if (operationQueue)
    {
        return operationQueue;
    }
    
    operationQueue = NSOperationQueue.new;
    operationQueue.name = @"Automatic Writing Operation Queue";
    operationQueue.maxConcurrentOperationCount = 1;
    
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return operationQueue;
}

- (void)yn_setTextWithAutomaticWritingAnimation:(NSString *)text
{
    [self yn_setText:text automaticWritingAnimationWithBlinkingMode:UILabelYNlinkingModeNone];
}

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelYNlinkingMode)blinkingMode
{
    [self yn_setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration
{
    [self yn_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:UILabelYNlinkingModeNone];
}

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelYNlinkingMode)blinkingMode
{
    [self yn_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelYNlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter
{
    [self yn_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)yn_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelYNlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion
{
    self.yn_automaticWritingOperationQueue.suspended = YES;
    self.yn_automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    
    if (text)
    {
        [automaticWritingText appendString:text];
    }
    
    [self.yn_automaticWritingOperationQueue addOperationWithBlock:^{
        [self yn_automaticWriting:automaticWritingText duration:duration mode:blinkingMode character:blinkingCharacter completion:completion];
    }];
}

#pragma mark - Private Methods

- (void)yn_automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(UILabelYNlinkingMode)mode character:(unichar)character completion:(void (^)(void))completion
{
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= UILabelYNlinkingModeWhenFinish) && !currentQueue.isSuspended)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != UILabelYNlinkingModeNone)
            {
                if ([self yn_isLastCharacter:character])
                {
                    [self yn_deleteLastCharacter];
                }
                else if (mode != UILabelYNlinkingModeWhenFinish || !text.length)
                {
                    [text insertString:[self yn_stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length)
            {
                [self yn_appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self yn_isLastCharacter:character] && mode == UILabelYNlinkingModeWhenFinishShowing) || (!text.length && mode == UILabelYNlinkingModeUntilFinishKeeping))
                {
                    [self yn_appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended)
            {
                [currentQueue addOperationWithBlock:^{
                    [self yn_automaticWriting:text duration:duration mode:mode character:character completion:completion];
                }];
            }
            else if (completion)
            {
                completion();
            }
        });
    }
    else if (completion)
    {
        completion();
    }
}

- (NSString *)yn_stringWithCharacter:(unichar)character
{
    return [self yn_stringWithCharacters:@[@(character)]];
}

- (NSString *)yn_stringWithCharacters:(NSArray *)characters
{
    NSMutableString *string = NSMutableString.new;
    
    for (NSNumber *character in characters)
    {
        [string appendFormat:@"%C", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)yn_appendCharacter:(unichar)character
{
    [self yn_appendCharacters:@[@(character)]];
}

- (void)yn_appendCharacters:(NSArray *)characters
{
    self.text = [self.text stringByAppendingString:[self yn_stringWithCharacters:characters]];
}

- (BOOL)yn_isLastCharacters:(NSArray *)characters
{
    if (self.text.length >= characters.count)
    {
        return [self.text hasSuffix:[self yn_stringWithCharacters:characters]];
    }
    return NO;
}

- (BOOL)yn_isLastCharacter:(unichar)character
{
    return [self yn_isLastCharacters:@[@(character)]];
}

- (BOOL)yn_deleteLastCharacters:(NSUInteger)characters
{
    if (self.text.length >= characters)
    {
        self.text = [self.text substringToIndex:self.text.length-characters];
        return YES;
    }
    return NO;
}

- (BOOL)yn_deleteLastCharacter
{
    return [self yn_deleteLastCharacters:1];
}

@end
