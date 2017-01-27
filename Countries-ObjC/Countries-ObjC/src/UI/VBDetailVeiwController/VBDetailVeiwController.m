//
//  VBDetailVeiwController.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/27/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBDetailVeiwController.h"
#import "VBDetailVeiw.h"
#import "VBNetwork.h"

@interface VBDetailVeiwController ()
@property (nonatomic, readonly) VBDetailVeiw *rootView;

- (VBNetworkHandler)handler;
- (void)loadCountryWithName:(NSString *)name;

@end

@implementation VBDetailVeiwController

#pragma mark -
#pragma mark Accessors

VBRootViewAndReturnIfNilMacro(VBDetailVeiw);

-(void)setCountryName:(NSString *)countryName {
    if (_countryName != countryName) {
        _countryName = countryName;
        
        [self loadCountryWithName:_countryName];
    }
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark -
#pragma mark Private

- (VBNetworkHandler)handler {
    return ^(id object) {
        [self.rootView fillWithCountry:object];
    };
}

- (void)loadCountryWithName:(NSString *)name {
    VBNetwork *networkModel = [[VBNetwork alloc] initWithHandler:[self handler]];
    NSString* nameForUEL = [name stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    [networkModel prepareToLoadWith:nameForUEL];
}

@end
