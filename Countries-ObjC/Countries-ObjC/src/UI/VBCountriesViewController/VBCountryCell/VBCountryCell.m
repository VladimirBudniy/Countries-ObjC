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
#pragma mark Initializations and Deallocatins

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark -
#pragma mark Public

- (void)fillWithCounty:(VBCountry *)country {
    self.countryName.text = country.name;
    self.capitalName.text = country.capital;
}


@end
