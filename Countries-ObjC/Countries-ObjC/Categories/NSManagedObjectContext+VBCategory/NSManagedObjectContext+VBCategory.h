//
//  NSManagedObjectContext+VBCategory.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (VBCategory)

+ (id)findOrCreateEntityWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;
+ (id)createEntityWithName:(NSString *)name InContext:(NSManagedObjectContext *)context;

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)privateContext;

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)findEntityWithName:(NSString *)name;
+ (NSManagedObject *)findEntityWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;

+ (void)removeAllInBackground;

+ (void)saveInContext:(NSManagedObjectContext *)context;

@end
