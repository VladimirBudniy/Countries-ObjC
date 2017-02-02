//
//  VBNetworkModel.h
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VBNetworkHandler)(id object);

@interface VBNetworkModel : NSObject

+ (instancetype)modelWithHandler:(VBNetworkHandler)handler;

- (void)urlForLoadingWith:(id)hash;
- (void)addUrlStringForLoad:(id)urlString;
- (void)workWithJSON:(NSMutableArray *)json block:(id)block;

@end
