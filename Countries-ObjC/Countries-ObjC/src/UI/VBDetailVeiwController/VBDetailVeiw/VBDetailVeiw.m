//
//  VBDetailVeiw.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/27/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBDetailVeiw.h"
#import "VBCountry+CoreDataClass.h"
#import "VBAnnotation.h"

@interface VBDetailVeiw ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *capitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *populationLabel;
@property (weak, nonatomic) IBOutlet UILabel *languagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *nativeNameLanel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelCollection;

@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *capital;
@property (weak, nonatomic) IBOutlet UILabel *population;
@property (weak, nonatomic) IBOutlet UILabel *languages;
@property (weak, nonatomic) IBOutlet UILabel *nativeName;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void)loadText;
- (void)loadedTextFrom:(VBCountry *)country;
- (void)loadMapForCountry:(VBCountry *)country;
- (void)settingMapView;
- (void)zeroAlpha;

@end

@implementation VBDetailVeiw

#pragma mark -
#pragma mark Initializations and Deallocatins

-(void)awakeFromNib {
    [super awakeFromNib];
    [self zeroAlpha];
    [self settingMapView];
}

#pragma mark -
#pragma mark Public

- (void)fillWithCountry:(VBCountry *)country {
    [self loadedTextFrom:country];
    [self loadMapForCountry:country];
}

#pragma mark -
#pragma mark MKMapViewDelegate

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    [UIView animateWithDuration:3 animations:^{
        self.mapView.alpha = 1;
    }];
}

#pragma mark -
#pragma mark Private

- (void)settingMapView {
    self.mapView.delegate = self;
}

- (void)loadMapForCountry:(VBCountry *)country {
    CLLocationCoordinate2D location;
    location.latitude = country.latitude.doubleValue;
    location.longitude= country.longitude.doubleValue;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 10000, 10000);
    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotation:[[VBAnnotation alloc] initWith:country.name
                                                      subtitle:country.capital
                                                    coordinate:location]];
}

- (void)loadedTextFrom:(VBCountry *)country {
    self.country.text = country.name;
    self.capital.text = country.capital;
    self.population.text = [[NSNumber numberWithInteger:country.population] stringValue];
    self.nativeName.text = country.nativeName;
    self.languages.text = country.languages;
    
    [UIView animateWithDuration:1 animations:^{
        [self loadText];
    }];
}

- (void)loadText {
    for (UILabel *label in self.labelCollection) {
        label.alpha = 1;
        label.textColor = [UIColor blackColor];
    }
}

- (void)zeroAlpha {
    self.mapView.alpha = 0;
    for (UILabel *label in self.labelCollection) {
        label.alpha = 0;
    }
}

@end
