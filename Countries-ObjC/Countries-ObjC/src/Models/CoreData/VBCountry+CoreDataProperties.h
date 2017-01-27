//
//  VBCountry+CoreDataProperties.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBCountry+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface VBCountry (CoreDataProperties)

+ (NSFetchRequest<VBCountry *> *)fetchRequest;

@property (nonatomic, copy) NSString *capital;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *currencies;
@property (nonatomic, copy) NSString *languages;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *nativeName;
@property (nonatomic, copy) NSString *region;

@property (nonatomic, assign) int64_t population;

@end

NS_ASSUME_NONNULL_END
