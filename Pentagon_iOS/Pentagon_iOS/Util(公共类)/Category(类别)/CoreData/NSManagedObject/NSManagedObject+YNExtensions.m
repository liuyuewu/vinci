//
//  NSManagedObject+Extensions.m
//  kemmler
//
//  Created by Lars Kuhnt on 28.10.13.
//  Copyright (c) 2013 Coeus Solutions GmbH. All rights reserved.
//

#import "NSManagedObject+YNExtensions.h"

@implementation NSManagedObject (ynExtensions)

+ (id)yn_create:(NSManagedObjectContext*)context {
  return [NSEntityDescription insertNewObjectForEntityForName:[self yn_entityName] inManagedObjectContext:context];
}

+ (id)yn_create:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context {
  id instance = [self yn_create:context];
  [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [instance setValue:obj forKey:key];
  }];
  return instance;
}

+ (id)yn_find:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  return [context yn_fetchObjectForEntity:[self yn_entityName] predicate:predicate];
}

+ (id)yn_find:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context {
  return [context yn_fetchObjectForEntity:[self yn_entityName] predicate:predicate sortDescriptors:sortDescriptors];
}

+ (NSArray*)yn_all:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  return [context yn_fetchObjectsForEntity:[self yn_entityName] predicate:predicate];
}

+ (NSArray *)yn_all:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context {
  return [context yn_fetchObjectsForEntity:[self yn_entityName] predicate:predicate sortDescriptors:sortDescriptors];
}

+ (NSUInteger)yn_count:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:[self yn_entityName] inManagedObjectContext:context];
  [request setPredicate:predicate];
  [request setEntity:entity];
  NSError *error = nil;
  return [context countForFetchRequest:request error:&error];
}

+ (NSString *)yn_entityName {
  return [NSString stringWithCString:object_getClassName(self) encoding:NSASCIIStringEncoding];
}

+ (NSError*)yn_deleteAll:(NSManagedObjectContext*)context {
  NSFetchRequest * req = [[NSFetchRequest alloc] init];
  [req setEntity:[NSEntityDescription entityForName:[self yn_entityName] inManagedObjectContext:context]];
  [req setIncludesPropertyValues:NO]; //only fetch the managedObjectID

  NSError * error = nil;
  NSArray * objects = [context executeFetchRequest:req error:&error];
  //error handling goes here
  for (NSManagedObject * obj in objects) {
    [context deleteObject:obj];
  }
  NSError *saveError = nil;
  [context save:&saveError];
  return error;
}

@end
