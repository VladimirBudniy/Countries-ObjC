//
//  VBNetwork.h
//  Counries-ObjC
//
//  Created by Vladimir Budniy on 1/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBNetwork.h"

typedef void (^VBNetworkHandler)(id object);

@interface VBNetwork : NSObject

- (instancetype)initWithHandler:(VBNetworkHandler)handler;
- (void)prepareToLoadWith:(id)urlPart;

@end
