//
//  VBNetworkModel.m
//  Countries-ObjC
//
//  Created by Vladimir Budniy on 2/1/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBNetworkModel.h"

@interface VBNetworkModel ()
@property (nonatomic, strong) NSURLSession      *session;
@property (nonatomic, strong) NSURLSessionTask  *task;

@property (nonatomic, copy)   NSString          *urlString;
@property (nonatomic, strong) NSArray           *array;
@property (nonatomic, strong) VBNetworkHandler  networkHandler;

- (instancetype)initWithHandler:(VBNetworkHandler)handler;
- (void)finishLoad;
- (void)loadWithURL:(NSString *)url;
- (VBParserHandler)parseHandler;

@end

@implementation VBNetworkModel

#pragma mark -
#pragma mark Accessors

-(void)setUrlString:(NSString *)urlString {
    if (_urlString != urlString) {
        _urlString = [urlString copy];
        
        [self loadWithURL:_urlString];
    }
}

-(void)setArray:(NSArray *)array {
    if (_array != array) {
        _array = array;
        
        [self finishLoad];
    }
}

#pragma mark -
#pragma mark Initializations and Deallocatins

- (void)dealloc {
    self.session = nil;
    self.task = nil;
}

- (instancetype)initWithHandler:(VBNetworkHandler)handler {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config];
        self.networkHandler = handler;
    }
    
    return self;
}

#pragma mark -
#pragma mark Class methods

+ (instancetype)modelWithHandler:(VBNetworkHandler)handler {
    return [[[self class] alloc] initWithHandler:handler];
}

#pragma mark -
#pragma mark Public

- (void)urlForLoadingWith:(id)hash {
    
}

- (void)addUrlStringForLoad:(id)urlString {
    self.urlString = urlString;
}

- (void)workWithJSON:(NSMutableArray *)json block:(id)block {
    
}

#pragma mark -
#pragma mark Private

- (VBParserHandler)parseHandler {
    return ^(id objects) {
        self.array = objects;
    };
}

- (void)finishLoad {
    self.networkHandler(self.array);
    [self.task cancel];
}

- (void)loadWithURL:(NSString *)url {
    NSURL *URL = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    
    self.task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                                              NSURLResponse *response,
                                                                              NSError *error) {
        if (!error) {
            [self workWithJSON:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] block:[self parseHandler]];
        } else {
            NSLog(@"Error of session - %@", error);
        }
    }];
    
    [self.task resume];
}

@end
