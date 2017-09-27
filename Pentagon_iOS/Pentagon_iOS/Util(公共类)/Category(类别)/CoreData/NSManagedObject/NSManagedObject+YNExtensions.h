//
//  NSManagedObject+Extensions.h
//  kemmler
//
//  Created by Lars Kuhnt on 28.10.13.
//  Copyright (c) 2013 Coeus Solutions GmbH. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+YNExtensions.h"

@interface NSManagedObject (YNExtensions)

+ (id)yn_create:(NSManagedObjectContext*)context;
+ (id)yn_create:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context;
+ (id)yn_find:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (id)yn_find:(NSPredicate *)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSArray*)yn_all:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray*)yn_all:(NSPredicate *)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSUInteger)yn_count:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)contex;
+ (NSString *)yn_entityName;
+ (NSError*)yn_deleteAll:(NSManagedObjectContext*)context;

@end
