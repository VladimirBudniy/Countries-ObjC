//
//  VBDetailVeiwController.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/27/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBDetailVeiwController.h"
#import "VBDetailVeiw.h"
#import "VBNetworkCountry.h"

VBViewControllerRootViewProperty(VBDetailVeiwController, VBDetailVeiw)

@interface VBDetailVeiwController ()
@property (nonatomic, copy)     NSString     *countryName;

- (VBNetworkHandler)handler;
- (void)loadCountryWithName:(NSString *)name;

@end

@implementation VBDetailVeiwController

#pragma mark -
#pragma mark Accessors

-(void)setCountryName:(NSString *)countryName {
    if (_countryName != countryName) {
        _countryName = [countryName copy];
        
        [self loadCountryWithName:_countryName];
    }
}

#pragma mark -
#pragma mark Initializations and Deallocatins

- (instancetype)initWithCountryName:(NSString *)name {
    self = [super init];
    if (self) {
        self.countryName = name;
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (VBNetworkHandler)handler {
    return ^(id object) {
        [self.rootView fillWithCountry:object];
    };
}

- (void)loadCountryWithName:(NSString *)name {
    VBNetworkCountry *model = [VBNetworkCountry modelWithHandler:[self handler]];
    NSString *hash = [name stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    [model urlForLoadingWith:hash];
}

@end
