//
//  VBDetailVeiw.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/27/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "VBDetailVeiw.h"

@interface VBDetailVeiw ()
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *capital;
@property (weak, nonatomic) IBOutlet UILabel *population;
@property (weak, nonatomic) IBOutlet UILabel *languages;
@property (weak, nonatomic) IBOutlet UILabel *nativeName;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation VBDetailVeiw

@end
