//
//  RSSFeedParser.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 08/07/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

@class FBRSSFeedParser;

@protocol FBRSSFeedParserDelegate <NSObject>

@optional
- (void)parser:(FBRSSFeedParser*)parser didFinishParsingFeed:(Feed*)feed;
- (void)parser:(FBRSSFeedParser*)parser didFinishParsingError:(NSError*)error;

@end

extern NSString * const RSSTitleTag;
extern NSString * const RSSLinkTag;
extern NSString * const RSSDateTag;
extern NSString * const RSSDescriptionTag;

@interface FBRSSFeedParser : NSObject <NSXMLParserDelegate>

@property (weak, nonatomic) id<FBRSSFeedParserDelegate> delegate;

/**
 If set when parsing a feed, the feed behind this property will be used for update, 
 otherwise a new entity will be generated.
 */
@property (strong, nonatomic) Feed * rssFeed;

- (instancetype)initWithData:(NSData*)data;
- (instancetype)initWithData:(NSData*)data managedObjectContext:(NSManagedObjectContext*)context;
- (instancetype)initWithData:(NSData*)data delegate:(id<FBRSSFeedParserDelegate>)delegate;
- (instancetype)initWithData:(NSData*)data delegate:(id<FBRSSFeedParserDelegate>)delegate managedObjectContext:(NSManagedObjectContext*)context;

- (void)parse;

@end
