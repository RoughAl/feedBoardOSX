//
//  FBRSSFeedService.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 08/07/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Feed, Item;

@interface FBRSSFeedService : NSObject

+ (instancetype)feedServiceWithManagedObjectContext:(NSManagedObjectContext*)context;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)context;

- (Feed*)feed;
- (Feed*)feedWithURLString:(NSString*)urlString;
- (Item*)feedItem;
- (Item*)feedItemWithURLString:(NSString*)urlString;
- (Item*)feedItemFromDictionary:(NSDictionary*)dictionary;

@end
