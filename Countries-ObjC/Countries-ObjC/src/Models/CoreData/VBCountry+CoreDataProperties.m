//
//  VBCountry+CoreDataProperties.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBCountry+CoreDataProperties.h"

@implementation VBCountry (CoreDataProperties)

+ (NSFetchRequest<VBCountry *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"VBCountry"];
}

@dynamic capital;
@dynamic name;
@dynamic currencies;
@dynamic languages;
@dynamic latitude;
@dynamic longitude;
@dynamic nativeName;
@dynamic population;
@dynamic region;

@end
