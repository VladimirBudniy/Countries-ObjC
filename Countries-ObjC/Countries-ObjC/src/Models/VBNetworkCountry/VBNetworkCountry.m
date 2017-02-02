//
//  VBNetworkCountry.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBNetworkCountry.h"

static NSString * const countryDetailsURL = @"https://restcountries.eu/rest/v1/name/%@";

@implementation VBNetworkCountry

- (void)urlForLoadingWith:(NSString *)hash {
    [self addUrlStringForLoad:[NSString stringWithFormat:countryDetailsURL, hash]];
}

- (void)workWithJSON:(NSMutableArray *)json block:(id)block{
    [VBCountry parseJSON:json withType:kVBCountryDataType handler:block];
}

@end
