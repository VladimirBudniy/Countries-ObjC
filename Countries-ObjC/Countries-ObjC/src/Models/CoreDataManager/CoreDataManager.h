//
//  CoreDataManager.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject
@property (readonly, strong) NSPersistentContainer  *persistentContainer;

+ (instancetype)shared;

- (NSManagedObjectContext *)mainContext;

@end
