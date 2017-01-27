//
//  VBParser.h
//  Counries-ObjC
//
//  Created by Vladimir Budniy on 1/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBParser.h"

typedef void (^VBParserHandler)(id objects);

typedef NS_ENUM(NSUInteger, VBParseDataType) {
    kVBCountriesDataType,
    kVBCountryDataType
};

@interface VBParser : NSObject

- (instancetype)initWithJson:(NSArray *)json handler:(VBParserHandler)parseHandler;
- (void)parseWith:(VBParseDataType)type;

@end
