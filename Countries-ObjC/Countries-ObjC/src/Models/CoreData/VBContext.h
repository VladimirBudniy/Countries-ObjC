//
//  VBContext.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface VBContext : NSObject

@property (readonly, strong) NSPersistentContainer  *persistentContainer;

+ (instancetype)sharedObject;

- (id)findOrCreateCountryWithName:(NSString *)name;
- (id)findOrCreateCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;
- (id)createCountryWithName:(NSString *)name InContext:(NSManagedObjectContext *)context;

- (NSArray *)findAll;
- (NSArray *)findAllInContext:(NSManagedObjectContext *)context;
- (NSManagedObject *)findCountryWithName:(NSString *)name;
- (NSManagedObject *)findCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;

- (void)removeAll;
- (void)removeCountryWithName:(NSString *)name;
- (void)removeCountry:(NSManagedObject *)country inContext:(NSManagedObjectContext *)context;

- (NSManagedObjectContext *)mainContext;

- (void)saveContext;
- (void)saveInContext:(NSManagedObjectContext *)context;

@end
