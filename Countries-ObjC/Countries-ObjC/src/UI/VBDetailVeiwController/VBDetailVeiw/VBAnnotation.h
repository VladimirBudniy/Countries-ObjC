//
//  VBAnnotation.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 1/27/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface VBAnnotation : NSObject <MKAnnotation>

- (instancetype)initWith:(NSString *)title subtitle:(NSString *)subtitle coordinate:(CLLocationCoordinate2D)coordinate;

@end
