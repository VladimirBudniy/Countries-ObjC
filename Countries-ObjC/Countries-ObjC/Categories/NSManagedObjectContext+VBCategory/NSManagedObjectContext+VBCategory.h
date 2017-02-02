//
//  NSManagedObjectContext+VBCategory.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (VBCategory)

+ (id)findOrCreateCountryWithName:(NSString *)name;
+ (id)findOrCreateCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;
+ (id)createCountryWithName:(NSString *)name InContext:(NSManagedObjectContext *)context;

+ (NSManagedObjectContext *)mainContext;
+ (NSManagedObjectContext *)privateContext;

+ (NSArray *)findAll;
+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)findCountryWithName:(NSString *)name;
+ (NSManagedObject *)findCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;

+ (void)removeAll;
+ (void)removeAllInBackground;

+ (void)removeCountryWithName:(NSString *)name;
+ (void)removeCountry:(NSManagedObject *)country inContext:(NSManagedObjectContext *)context;

+ (void)saveContext;
+ (void)saveInContext:(NSManagedObjectContext *)context;

@end
