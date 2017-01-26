//
//  VBParser.m
//  Counries-ObjC
//
//  Created by Vladimir Budniy on 1/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBCountry+CoreDataClass.h"
#import "VBParser.h"
#import "VBContext.h"

@interface VBParser ()
@property (nonatomic, strong) NSArray        *json;
@property (nonatomic, strong) VBParserHandler parseHandler;

@end

@implementation VBParser

#pragma mark -
#pragma mark Initializations and Deallocatins

- (instancetype)initWithJson:(NSArray *)json handler:(VBParserHandler)handler {
    self = [super init];
    if (self) {
        self.json = json;
        self.parseHandler = handler;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)parse {
    VBContext *sharedObject = [VBContext sharedObject];
    NSManagedObjectContext *mainContext = [sharedObject mainContext];
    NSManagedObjectContext *privateContext = [sharedObject privateContext];
    privateContext.parentContext = [sharedObject mainContext];
    NSArray *json = self.json;
    
    [privateContext performBlock:^{
        for (NSDictionary *item in json) {
            if (![[item valueForKey:@"capitalCity"] isEqualToString:@""]) {
                NSString *name = [item valueForKey:@"name"];
                VBCountry *country = [sharedObject findOrCreateCountryWithName:name];
                if (country) {
                    country.name = name;
                    country.capital = [item valueForKey:@"capitalCity"];
                    country.latitude = [item valueForKey:@"latitude"];
                    country.longitude = [item valueForKey:@"longitude"];
                }
            }
        }
        
        NSError *error = nil;
        [privateContext save:&error];
        
        [mainContext performBlockAndWait:^{
            NSError *error = nil;
            [mainContext save:&error];
            self.parseHandler([sharedObject findAll]);
        }];
    }];
}

@end
