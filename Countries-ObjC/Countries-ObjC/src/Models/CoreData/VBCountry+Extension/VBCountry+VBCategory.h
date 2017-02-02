//
//  VBCountry+VBCategory.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBCountry+CoreDataClass.h"

typedef void (^VBParserHandler)(id objects);

typedef NS_ENUM(NSUInteger, VBParseDataType) {
    kVBCountriesDataType,
    kVBCountryDataType
};

@interface VBCountry (VBCategory)

+ (void)parseJSON:(id)json withType:(VBParseDataType)type handler:(VBParserHandler)parseHandler;

@end
