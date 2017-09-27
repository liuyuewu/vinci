//
//  UIApplication-Permissions.m
//  UIApplication-Permissions Sample
//
//  Created by Jack Rostron on 12/01/2014.
//  Copyright (c) 2014 Rostron. All rights reserved.
//

#import "UIApplication+YNPermissions.h"
#import <objc/runtime.h>

//Import required frameworks
#import <AddressBook/AddressBook.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <EventKit/EventKit.h>

typedef void (^ynLocationSuccessCallback)();
typedef void (^ynLocationFailureCallback)();

static char ynPermissionsLocationManagerPropertyKey;
static char ynPermissionsLocationBlockSuccessPropertyKey;
static char ynPermissionsLocationBlockFailurePropertyKey;

@interface UIApplication () <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *yn_permissionsLocationManager;
@property (nonatomic, copy) ynLocationSuccessCallback yn_locationSuccessCallbackProperty;
@property (nonatomic, copy) ynLocationFailureCallback yn_locationFailureCallbackProperty;
@end


@implementation UIApplication (Permissions)


#pragma mark - Check permissions
-(YNPermissionAccess)hasAccessToBluetoothLE {
    switch ([[[CBCentralManager alloc] init] state]) {
        case CBCentralManagerStateUnsupported:
            return YNPermissionAccessUnsupported;
            break;
            
        case CBCentralManagerStateUnauthorized:
            return YNPermissionAccessDenied;
            break;
            
        default:
            return YNPermissionAccessGranted;
            break;
    }
}

-(YNPermissionAccess)hasAccessToCalendar {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            return YNPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return YNPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return YNPermissionAccessRestricted;
            break;
            
        default:
            return YNPermissionAccessUnknown;
            break;
    }
}

-(YNPermissionAccess)hasAccessToContacts {
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            return YNPermissionAccessGranted;
            break;
            
        case kABAuthorizationStatusDenied:
            return YNPermissionAccessDenied;
            break;
            
        case kABAuthorizationStatusRestricted:
            return YNPermissionAccessRestricted;
            break;
            
        default:
            return YNPermissionAccessUnknown;
            break;
    }
}

-(YNPermissionAccess)hasAccessToLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorizedAlways:
            return YNPermissionAccessGranted;
            break;
            
        case kCLAuthorizationStatusDenied:
            return YNPermissionAccessDenied;
            break;
            
        case kCLAuthorizationStatusRestricted:
            return YNPermissionAccessRestricted;
            break;
            
        default:
            return YNPermissionAccessUnknown;
            break;
    }
    return YNPermissionAccessUnknown;
}

-(YNPermissionAccess)hasAccessToPhotos {
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusAuthorized:
            return YNPermissionAccessGranted;
            break;
            
        case ALAuthorizationStatusDenied:
            return YNPermissionAccessDenied;
            break;
            
        case ALAuthorizationStatusRestricted:
            return YNPermissionAccessRestricted;
            break;
            
        default:
            return YNPermissionAccessUnknown;
            break;
    }
}

-(YNPermissionAccess)hasAccessToReminders {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusAuthorized:
            return YNPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return YNPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return YNPermissionAccessRestricted;
            break;
            
        default:
            return YNPermissionAccessUnknown;
            break;
    }
    return YNPermissionAccessUnknown;
}


#pragma mark - Request permissions
-(void)yn_requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)yn_requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if(addressBook) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    accessGranted();
                } else {
                    accessDenied();
                }
            });
        });
    }
}

-(void)yn_requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)yn_requestAccessToMotionWithSuccess:(void(^)())accessGranted {
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity) {
        accessGranted();
        [motionManager stopActivityUpdates];
    }];
}

-(void)yn_requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        accessGranted();
    } failureBlock:^(NSError *error) {
        accessDenied();
    }];
}

-(void)yn_requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}


#pragma mark - Needs investigating
/*
 -(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted {
 //REQUIRES DELEGATE - NEEDS RETHINKING
 }
 */

-(void)yn_requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    self.yn_permissionsLocationManager = [[CLLocationManager alloc] init];
    self.yn_permissionsLocationManager.delegate = self;
    
    self.yn_locationSuccessCallbackProperty = accessGranted;
    self.yn_locationFailureCallbackProperty = accessDenied;
    [self.yn_permissionsLocationManager startUpdatingLocation];
}


#pragma mark - Location manager injection
-(CLLocationManager *)yn_permissionsLocationManager {
    return objc_getAssociatedObject(self, &ynPermissionsLocationManagerPropertyKey);
}

-(void)setyn_permissionsLocationManager:(CLLocationManager *)manager {
    objc_setAssociatedObject(self, &ynPermissionsLocationManagerPropertyKey, manager, OBJC_ASSOCIATION_RETAIN);
}

-(ynLocationSuccessCallback)locationSuccessCallbackProperty {
    return objc_getAssociatedObject(self, &ynPermissionsLocationBlockSuccessPropertyKey);
}

-(void)setyn_locationSuccessCallbackProperty:(ynLocationSuccessCallback)locationCallbackProperty {
    objc_setAssociatedObject(self, &ynPermissionsLocationBlockSuccessPropertyKey, locationCallbackProperty, OBJC_ASSOCIATION_COPY);
}

-(ynLocationFailureCallback)locationFailureCallbackProperty {
    return objc_getAssociatedObject(self, &ynPermissionsLocationBlockFailurePropertyKey);
}

-(void)setyn_locationFailureCallbackProperty:(ynLocationFailureCallback)locationFailureCallbackProperty {
    objc_setAssociatedObject(self, &ynPermissionsLocationBlockFailurePropertyKey, locationFailureCallbackProperty, OBJC_ASSOCIATION_COPY);
}


#pragma mark - Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        self.locationSuccessCallbackProperty();
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        self.locationFailureCallbackProperty();
    }
}

@end
