//
//  VBCountry+VBCategory.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBCountry+VBCategory.h"

@implementation VBCountry (VBCategory)

+ (void)parseJSON:(id)json withType:(VBParseDataType)type handler:(VBParserHandler)parseHandler {
    NSManagedObjectContext *privateContext =  [NSManagedObjectContext privateContext];
    NSMutableArray *parseArray = [NSMutableArray new];
    [privateContext performBlock:^{
        for (NSDictionary *item in json) {
            if (![[item valueForKey:@"capitalCity"] isEqualToString:@""]) {
                NSString *name = [item valueForKey:@"name"];
                VBCountry *country = [NSManagedObjectContext findOrCreateEntityWithName:name inContext:privateContext];
                if (country && type == kVBCountriesDataType) {
                    country.capital = [item valueForKey:@"capitalCity"];
                    country.latitude = [item valueForKey:@"latitude"];
                    country.longitude = [item valueForKey:@"longitude"];
                } else if (country && type == kVBCountryDataType) {
                    country.population = ((NSNumber *)[item valueForKey:@"population"]).integerValue;
                    country.languages = [[item valueForKey:@"languages"] componentsJoinedByString:@", "];
                    country.nativeName = [item valueForKey:@"nativeName"];
                }
                
                [parseArray addObject:country];
            }
        }
        
        NSError *error = nil;
        [privateContext save:&error];
        
        [privateContext.parentContext performBlockAndWait:^{
            NSError *error = nil;
            [privateContext.parentContext save:&error];
            if (type == kVBCountriesDataType) {
                NSMutableArray *newArray = [NSMutableArray new];
                for (VBCountry *item in parseArray) {
                    [newArray addObject:[NSManagedObjectContext findEntityWithName:item.name inContext:privateContext.parentContext]];
                }
                parseHandler(newArray);
            } else {
                VBCountry *country = [parseArray firstObject];
                parseHandler([NSManagedObjectContext findEntityWithName:country.name inContext:privateContext.parentContext]);
            }
        }];
    }];
}

@end
