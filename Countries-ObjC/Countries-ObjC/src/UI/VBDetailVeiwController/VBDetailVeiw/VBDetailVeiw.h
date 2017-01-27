//
//  VBDetailVeiw.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/27/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class VBCountry;

@interface VBDetailVeiw : UIView <MKMapViewDelegate>

- (void)fillWithCountry:(VBCountry *)country;

@end
