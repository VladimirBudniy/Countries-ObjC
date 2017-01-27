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

@property (nonatomic, copy) NSString *currentCountryName;

@end

@implementation VBParser

#pragma mark -
#pragma mark Initializations and Deallocatins

- (void)dealloc {
    self.json = nil;
}

- (instancetype)initWithJson:(NSArray *)json handler:(VBParserHandler)parseHandler {
    self = [super init];
    if (self) {
        self.json = json;
        self.parseHandler = parseHandler;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)parseWith:(VBParseDataType)type {
    VBContext *sharedObject = [VBContext sharedObject];
    NSManagedObjectContext *mainContext = [sharedObject mainContext];
    NSManagedObjectContext *privateContext =  [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    privateContext.parentContext = mainContext;
    NSArray *json = self.json;
    
    [privateContext performBlock:^{
        for (NSDictionary *item in json) {
            if (![[item valueForKey:@"capitalCity"] isEqualToString:@""]) {
                NSString *name = [item valueForKey:@"name"];
                VBCountry *country = [sharedObject findOrCreateCountryWithName:name inContext:privateContext];
                if (country && type == kVBCountriesDataType) {
                    country.capital = [item valueForKey:@"capitalCity"];
                    country.latitude = [item valueForKey:@"latitude"];
                    country.longitude = [item valueForKey:@"longitude"];
                } else if (country && type == kVBCountryDataType) {
                    
                    self.currentCountryName = country.name;  // strongSelf!
                    
                    country.population = ((NSNumber *)[item valueForKey:@"population"]).integerValue;
                    country.languages = [[item valueForKey:@"languages"] componentsJoinedByString:@", "];
                    country.nativeName = [item valueForKey:@"nativeName"];
                }
            }
        }
        
        NSError *error = nil;
        [privateContext save:&error];
        
        [mainContext performBlockAndWait:^{
            NSError *error = nil;
            [mainContext save:&error];
            if (type == kVBCountriesDataType) {
                self.parseHandler([sharedObject findAllInContext:mainContext]);
            } else {
                self.parseHandler([sharedObject findCountryWithName:self.currentCountryName inContext:mainContext]);
            }
        }];
    }];
}

@end
