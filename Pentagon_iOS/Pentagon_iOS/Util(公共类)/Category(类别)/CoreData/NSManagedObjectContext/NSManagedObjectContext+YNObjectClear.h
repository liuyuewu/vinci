//
//  GON_NSManagedObjectContext+ynObjectClear.h
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (YNObjectClear)
/* Delete all given objects*/
- (void)yn_deleteObjects:(id <NSFastEnumeration>)objects;
@end
