//
//  FBServiceProvider.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 02/06/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "FBServiceProvider.h"
#import "FBDAOService.h"

static FBServiceProvider * sharedInstance;

@implementation FBServiceProvider {
    dispatch_queue_t _serviceQueue;

    FBDAOService * _DAOService;
}

+ (FBServiceProvider *)defaultProvider {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _serviceQueue = dispatch_queue_create("com.victo.feedboard.service_provider_quque", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (FBDAOService*)DAOService {
    dispatch_sync(_serviceQueue, ^{
        if (_DAOService == nil) {
            _DAOService = [[FBDAOService alloc] init];
        }
    });
    return _DAOService;
}

@end
