//
//  NSManagedObjectContext+VBCategory.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "NSManagedObjectContext+VBCategory.h"
#import "VBCountry+CoreDataClass.h"
#import "CoreDataManager.h"

static NSString * const kVBPredicateFormat = @"name = %@";

@implementation NSManagedObjectContext (VBCategory)

#pragma mark -
#pragma mark Accessors

+ (NSManagedObjectContext *)mainContext {
    return [[CoreDataManager shared] mainContext];
}

+ (NSManagedObjectContext *)privateContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = [self mainContext];
    
    return context;
    
//    NSPersistentStoreCoordinator *coordinator = [CoreDataManager shared].persistentContainer.persistentStoreCoordinator;
//    if (coordinator != nil) {
//        [context setPersistentStoreCoordinator:coordinator];
//    }
//    return context;
}

#pragma mark -
#pragma mark Public

+ (id)findOrCreateCountryWithName:(NSString *)name {
    return [self findOrCreateCountryWithName:name inContext:[self mainContext]];
}

+ (id)findOrCreateCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    id country = [self findCountryWithName:name inContext:context];
    if (country) {
        return country;
    }
    
    return [self createCountryWithName:(NSString *)name InContext:context];
}

+ (id)createCountryWithName:(NSString *)name InContext:(NSManagedObjectContext *)context {
    VBCountry *country = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([VBCountry class]) inManagedObjectContext:context];
    [country setValue:name forKey:@"name"];
    
    return country;
}

+ (NSArray *)findAll {
    return [self findAllInContext:[self mainContext]];
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [VBCountry fetchRequest];
    NSArray *arrayDescriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    request.sortDescriptors = arrayDescriptor;
    NSError *error = nil;
    
    return [context executeFetchRequest:request error:&error];
}

+ (NSManagedObject *)findCountryWithName:(NSString *)name {
    return [self findCountryWithName:name inContext:[self mainContext]];
}

+ (NSManagedObject *)findCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:kVBPredicateFormat, name];
    NSFetchRequest *request = [VBCountry fetchRequest];
    NSError *error = nil;
    request.predicate = predicate;
    
    return [[context executeFetchRequest:request error:&error] firstObject];
}

+ (void)removeAll {
    NSArray *countries = [self findAll];
    for (VBCountry *country in countries) {
        [[self mainContext] deleteObject:country];
    }
}

+ (void)removeAllInBackground {
    NSManagedObjectContext *privateContext = [NSManagedObjectContext privateContext];
    [privateContext performBlock:^{
        NSArray *countries = [NSArray new];
        countries = [NSManagedObjectContext findAllInContext:privateContext];
        for (NSManagedObject *managedObject in countries) {
            [privateContext deleteObject:managedObject];
        }
    }];
}

+ (void)removeCountryWithName:(NSString *)name {
    NSManagedObject *country = [self findCountryWithName:name];
    [self removeCountry:country inContext:[self mainContext]];
}

+ (void)removeCountry:(NSManagedObject *)country inContext:(NSManagedObjectContext *)context {
    [context deleteObject:country];
}

#pragma mark
#pragma mark Core Data Saving support

+ (void)saveContext {
    [self saveInContext:[self mainContext]];
}

+ (void)saveInContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
