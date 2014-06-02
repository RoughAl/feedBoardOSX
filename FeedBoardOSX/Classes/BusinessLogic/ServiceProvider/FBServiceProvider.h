//
//  FBServiceProvider.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 02/06/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBDAOService;

@interface FBServiceProvider : NSObject

/**
 Returns the shared instance of the Service Provider.
 @return the shared instance.
 */
+ (FBServiceProvider *)defaultProvider;

/**
 Creates an instance of the DAO service on demand.
 @return an instance of the DAO service.
 */
- (FBDAOService*)DAOService;

@end
