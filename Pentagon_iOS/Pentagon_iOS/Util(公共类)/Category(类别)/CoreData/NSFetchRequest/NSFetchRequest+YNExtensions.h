//
//  NSFetchRequest+Extensions.h
//
//  Created by Wess Cope on 9/23/11.
//  Copyright 2012. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef void (^FetchObjectsCallback)(NSArray *fetchedObjects, NSError *error);
typedef void (^FetchObjectCallback)(id fetchedObject, NSError * error);

@interface NSFetchRequest(YNExtensions)

+ (id)yn_fetchRequestWithEntity:(NSEntityDescription *)entity;
+ (id)yn_fetchRequestWithEntity:(NSEntityDescription *)entity predicate:(NSPredicate *)predicate;
+ (id)yn_fetchRequestWithEntity:(NSEntityDescription *)entity sortDescriptors:(NSArray *)sortDescriptors;
+ (id)yn_fetchRequestWithEntity:(NSEntityDescription *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

- (id)initWithEntity:(NSEntityDescription *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

@end
