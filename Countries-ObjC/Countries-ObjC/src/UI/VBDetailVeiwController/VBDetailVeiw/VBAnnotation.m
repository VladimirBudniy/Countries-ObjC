//
//  VBAnnotation.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/27/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBAnnotation.h"

@interface VBAnnotation()
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;

@end

@implementation VBAnnotation

- (instancetype)initWith:(NSString *)title subtitle:(NSString *)subtitle coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }

    return self;
}

@end
