//
//  VBCountryCell.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBCountryCell.h"

@implementation VBCountryCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(VBCountry *)model {
    self.countryName.text = model.name;
    self.capitalName.text = model.capital;
}

@end
