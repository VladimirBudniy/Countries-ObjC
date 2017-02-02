//
//  CoreDataManager.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "CoreDataManager.h"

static CoreDataManager *__manager = nil;

@implementation CoreDataManager

#pragma mark -
#pragma mark Singleton

+ (id)sharedManager {
    return self.sharedManager;
}

#pragma mark -
#pragma mark Initializations and Deallocatins

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__manager) {
            __manager = [self new];
        }
    });
    
    return __manager;
}

#pragma mark -
#pragma mark Singleton Service

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t once;
    __block id result = __manager;
    dispatch_once(&once, ^{
        if (!__manager) {
            result = [super allocWithZone:zone];
        }
    });
    
    return result;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (id)retain {
    return self;
}

+ (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

+ (oneway void)release {
    //do nothing
}

+ (id)autorelease {
    return self;
}

#pragma mark -
#pragma mark Public

- (NSManagedObjectContext *)mainContext {
    return [[self persistentContainer] viewContext];
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

@end
