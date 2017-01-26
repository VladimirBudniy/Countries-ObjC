//
//  VBContext.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBContext.h"
#import "VBCountry+CoreDataClass.h"

static NSString * const kVBPredicateFormat = @"name = %@";

@implementation VBContext

#pragma mark -
#pragma mark Initializations and Deallocatins

+ (instancetype)sharedObject {
    static dispatch_once_t onceToken;
    static VBContext *context = nil;
    dispatch_once(&onceToken, ^{
        context = [self new];
    });
    
    return context;
}

#pragma mark -
#pragma mark Public

- (id)findOrCreateCountryWithName:(NSString *)name {
    NSManagedObjectContext *context = [self mainContext];
    
    return [self findOrCreateCountryWithName:name inContext:context];
}

- (id)findOrCreateCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    id country = [self findCountryWithName:name inContext:context];
    if (country) {
        return country;
    }

    return [self createCountryWithName:(NSString *)name InContext:context];
}

- (id)createCountryWithName:(NSString *)name InContext:(NSManagedObjectContext *)context {
    VBCountry *country = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([VBCountry class]) inManagedObjectContext:context];
    [country setValue:name forKey:@"name"];
    
    return country;
}

- (NSArray *)findAll {
    return [self findAllInContext:[self mainContext]];
}

- (NSArray *)findAllInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [VBCountry fetchRequest];
    NSArray *arrayDescriptor = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    request.sortDescriptors = arrayDescriptor;
    NSError *error = nil;
    
    return [context executeFetchRequest:request error:&error];
}

- (NSManagedObject *)findCountryWithName:(NSString *)name {
    NSManagedObjectContext *mainContext = [self mainContext];
    
    return [self findCountryWithName:name inContext:mainContext];
}

- (NSManagedObject *)findCountryWithName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:kVBPredicateFormat, name];
    NSFetchRequest *request = [VBCountry fetchRequest];
    NSError *error = nil;
    request.predicate = predicate;
    
    return [[context executeFetchRequest:request error:&error] firstObject];
}

- (void)removeAll {
    NSArray *countries = [self findAll];
    for (VBCountry *country in countries) {
        [[self mainContext] deleteObject:country];
    }
}

- (void)removeCountryWithName:(NSString *)name {
    NSManagedObject *country = [self findCountryWithName:name];
    [self removeCountry:country inContext:[self mainContext]];
}

- (void)removeCountry:(NSManagedObject *)country inContext:(NSManagedObjectContext *)context {
    [context deleteObject:country];
}

- (NSManagedObjectContext *)mainContext {
    return [[self persistentContainer] viewContext];
}

- (NSManagedObjectContext *)privateContext {
    return [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
}

#pragma mark -
#pragma mark Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"VBCountry"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark
#pragma mark Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = [[self persistentContainer] viewContext];
    [self saveInContext:context];
}

- (void)saveInContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
