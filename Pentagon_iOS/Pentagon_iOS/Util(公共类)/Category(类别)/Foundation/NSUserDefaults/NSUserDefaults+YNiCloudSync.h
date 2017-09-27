//
//  NSUserDefaults+iCloudSync.h
//
//  Created by Riccardo Paolillo on 09/05/13.
//  Copyright (c) 2013. All rights reserved.
//

//https://github.com/RiccardoPaolillo/NSUserDefault-iCloud
// A very simple iOS Category for synchronize NSUserDefaults with iCloud (NSUbiquitousKeyValueStore)

#import <Foundation/Foundation.h>


@interface NSUserDefaults (YNiCloudSync)

-(void)yn_setValue:(id)value  forKey:(NSString *)key iCloudSync:(BOOL)sync;
-(void)yn_setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

-(id)yn_valueForKey:(NSString *)key iCloudSync:(BOOL)sync;
-(id)yn_objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

-(BOOL)yn_synchronizeAlsoiCloudSync:(BOOL)sync;

@end

