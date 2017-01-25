//
//  VBCountryCell.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBCountry+CoreDataClass.h"

@interface VBCountryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *countryName;
@property (weak, nonatomic) IBOutlet UILabel *capitalName;

- (void)fillWithCounty:(VBCountry *)country;

@end
