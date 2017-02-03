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

//+ (id)findOrCreateEntityWithName:(NSString *)name {
//    return [self findOrCreateEntityWithName:name inContext:[self mainContext]];
//}

+ (id)findOrCreateEntityWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    id country = [self findEntityWithName:name inContext:context];
    if (country) {
        return country;
    }
    
    return [self createEntityWithName:(NSString *)name InContext:context];
}

+ (id)createEntityWithName:(NSString *)name InContext:(NSManagedObjectContext *)context {
    VBCountry *country = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([VBCountry class]) inManagedObjectContext:context];
    [country setValue:name forKey:@"name"];
    
    return country;
}

//+ (NSArray *)findAll {
//    return [self findAllInContext:[self mainContext]];
//}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [VBCountry fetchRequest];
    NSArray *arrayDescriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    request.sortDescriptors = arrayDescriptor;
    NSError *error = nil;
    
    return [context executeFetchRequest:request error:&error];
}

+ (NSManagedObject *)findEntityWithName:(NSString *)name {
    return [self findEntityWithName:name inContext:[self mainContext]];
}

+ (NSManagedObject *)findEntityWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:kVBPredicateFormat, name];
    NSFetchRequest *request = [VBCountry fetchRequest];
    NSError *error = nil;
    request.predicate = predicate;
    
    return [[context executeFetchRequest:request error:&error] firstObject];
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

#pragma mark
#pragma mark Core Data Saving support

+ (void)saveInContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
