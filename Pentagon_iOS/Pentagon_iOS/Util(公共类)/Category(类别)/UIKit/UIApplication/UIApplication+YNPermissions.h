//
//  UIApplication-Permissions.h
//  UIApplication-Permissions Sample
//
//  Created by Jack Rostron on 12/01/2014.
//  Copyright (c) 2014 Rostron. All rights reserved.
//  https://github.com/JackRostron/UIApplication-Permissions
//   Category on UIApplication that adds permission helpers


#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

typedef enum {
    YNPermissionTypeBluetoothLE,
    YNPermissionTypeCalendar,
    YNPermissionTypeContacts,
    YNPermissionTypeLocation,
    YNPermissionTypeMicrophone,
    YNPermissionTypeMotion,
    YNPermissionTypePhotos,
    YNPermissionTypeReminders,
} YNPermissionType;

typedef enum {
    YNPermissionAccessDenied, //User has rejected feature
    YNPermissionAccessGranted, //User has accepted feature
    YNPermissionAccessRestricted, //Blocked by parental controls or system settings
    YNPermissionAccessUnknown, //Cannot be determined
    YNPermissionAccessUnsupported, //Device doesn't support this - e.g Core Bluetooth
    YNPermissionAccessMissingFramework, //Developer didn't import the required framework to the project
} YNPermissionAccess;

@interface UIApplication (YNPermissions)

//Check permission of service. Cannot check microphone or motion without asking user for permission
-(YNPermissionAccess)yn_hasAccessToBluetoothLE;
-(YNPermissionAccess)yn_hasAccessToCalendar;
-(YNPermissionAccess)yn_hasAccessToContacts;
-(YNPermissionAccess)yn_hasAccessToLocation;
-(YNPermissionAccess)yn_hasAccessToPhotos;
-(YNPermissionAccess)yn_hasAccessToReminders;

//Request permission with callback
-(void)yn_requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)yn_requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)yn_requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)yn_requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)yn_requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

//Instance methods
-(void)yn_requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

//No failure callback available
-(void)yn_requestAccessToMotionWithSuccess:(void(^)())accessGranted;

//Needs investigating - unsure whether it can be implemented because of required delegate callbacks
//-(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted;

@end
