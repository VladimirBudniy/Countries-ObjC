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

@property (nullable, nonatomic, copy) NSString *capital;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *currencies;
@property (nullable, nonatomic, copy) NSString *languages;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *nativeName;
@property (nonatomic) int64_t population;
@property (nullable, nonatomic, copy) NSString *region;

@end

NS_ASSUME_NONNULL_END
