//
//  UIViewController+StoreKit.h
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//  https://github.com/mergesort/UIViewController-StoreKit

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

#define affiliateToken @"10laQX"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (YNStoreKit)

@property NSString *yn_campaignToken;
@property (nonatomic, copy) void (^yn_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^yn_loadedStoreKitItemBlock)(void);

- (void)yn_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (NSURL*)yn_appURLForIdentifier:(NSInteger)identifier;

+ (void)yn_openAppURLForIdentifier:(NSInteger)identifier;
+ (void)yn_openAppReviewURLForIdentifier:(NSInteger)identifier;

+ (BOOL)yn_containsITunesURLString:(NSString*)URLString;
+ (NSInteger)yn_IDFromITunesURL:(NSString*)URLString;

@end
