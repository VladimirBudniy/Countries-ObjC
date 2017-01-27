//
//  VBNetwork.m
//  Counries-ObjC
//
//  Created by Vladimir Budniy on 1/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

#import "VBNetwork.h"
#import "VBParser.h"

static NSString * const requestedURL      = @"http://api.worldbank.org/countries?per_page=30&format=json&page=%@";
static NSString * const countryDetailsURL = @"https://restcountries.eu/rest/v1/name/%@";

typedef void (^VBNetworkHandler)(id object);

@interface VBNetwork ()
@property (nonatomic, strong) NSURLSession      *session;
@property (nonatomic, strong) NSURLSessionTask  *task;
@property (nonatomic, strong) NSArray           *array;
@property (nonatomic, strong) VBNetworkHandler  networkHandler;

- (void)finishLoad;
- (void)loadWithURL:(NSString *)url;
- (VBParserHandler)parseHandler;

@end

@implementation VBNetwork

#pragma mark -
#pragma mark Accessors

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
    self.array = nil;
    self.networkHandler = nil;
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
#pragma mark Public

- (void)prepareToLoadWith:(id)urlPart {
    [self loadWithURL:[self urlFor:urlPart]];
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

- (NSString *)urlFor:(id)urlPart {
    if ([urlPart isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:countryDetailsURL, urlPart];
    } else if ([urlPart isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:requestedURL, [(NSNumber *)urlPart stringValue]];
    }
    
    return nil;
}

- (void)loadWithURL:(NSString *)url {
    NSURL *URL = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    
    self.task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                                              NSURLResponse *response,
                                                                              NSError *error) {
        if (!error) {
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (json.count > 1) {
                // NSLog(@"%@", json);
                [[[VBParser alloc] initWithJson:[json lastObject] handler:[self parseHandler]] parse];
            } else {
                 [[[VBParser alloc] initWithJson:json handler:[self parseHandler]] parse];
            }
            
        } else {
            NSLog(@"Print error - %@", error);
        }
    }];
    
    [self.task resume];
}

@end
