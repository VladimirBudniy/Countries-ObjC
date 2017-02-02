//
//  VBNetworkCountries.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBNetworkCountries.h"
#import "VBCountry+CoreDataClass.h"

static NSString * const requestedURL = @"http://api.worldbank.org/countries?per_page=30&format=json&page=%@";

@implementation VBNetworkCountries

- (void)urlForLoadingWith:(NSNumber *)hash {
    [self addUrlStringForLoad:[NSString stringWithFormat:requestedURL, [(NSNumber *)hash stringValue]]];
}

- (void)workWithJSON:(NSMutableArray *)json block:(id)block {
    [VBCountry parseJSON:json.lastObject withType:kVBCountriesDataType handler:block];
}

@end
