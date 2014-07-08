//
//  RSSFeedParser.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 08/07/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "FBRSSFeedParser.h"
#import "FBServiceProvider.h"
#import "FBDAOService.h"
#import "Item.h"
#import "FBRSSFeedService.h"

#pragma mark - Base Class Extension

@interface FBRSSFeedParser () {
    BOOL _isContextOwned;
    BOOL _parserIsWithinItemTag;
}

@property (strong, nonatomic) NSData * feedData;
@property (strong, nonatomic) NSManagedObjectContext * context;
@property (strong, nonatomic) NSXMLParser * parser;
@property (strong, nonatomic) NSString * currentXMLContainerTag;
@property (strong, nonatomic) FBRSSFeedService * feedService;

@property (strong, nonatomic) NSDictionary * feedItemDataContainer;

@end

@implementation FBRSSFeedParser

#pragma mark - Constants

NSString * const RSSTitleTag = @"title";
NSString * const RSSLinkTag = @"link";
NSString * const RSSDateTag = @"pubDate";
NSString * const RSSDescriptionTag = @"description";
NSString * const RSSItemTag = @"item";

#pragma mark - Base methods

- (instancetype)initWithData:(NSData*)data {
    return [self initWithData:data delegate:nil managedObjectContext:nil];
}

- (instancetype)initWithData:(NSData*)data managedObjectContext:(NSManagedObjectContext*)context {
    return [self initWithData:data delegate:nil managedObjectContext:context];
}

- (instancetype)initWithData:(NSData*)data delegate:(id<FBRSSFeedParserDelegate>)delegate {
    return [self initWithData:data delegate:delegate managedObjectContext:nil];
}

- (instancetype)initWithData:(NSData*)data delegate:(id<FBRSSFeedParserDelegate>)delegate managedObjectContext:(NSManagedObjectContext*)context {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _feedData = data;
        if (context != nil) {
            _context = context;
        }
        else {
            _context = [[NSManagedObjectContext alloc] init];
            _context.parentContext = [[[FBServiceProvider defaultProvider] DAOService] rootContext];
            _isContextOwned = YES;
        }
        _feedService = [FBRSSFeedService feedServiceWithManagedObjectContext:_context];
    }
    return self;
}

- (void)parse {
    if (self.feedData != nil) {
        if (self.rssFeed == nil) {
            self.rssFeed = [_feedService feed];
        }

        self.parser = [[NSXMLParser alloc] initWithData:self.feedData];
        self.parser.delegate = self;
        [self.parser parse];
    }
}

#pragma mark - XML Parser Delegate Methods

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([self.delegate respondsToSelector:@selector(parser:didFinishParsingFeed:)]) {
        [self.delegate parser:self didFinishParsingFeed:self.rssFeed];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if ([self.delegate respondsToSelector:@selector(parser:didFinishParsingError:)]) {
        [self.delegate parser:self didFinishParsingError:parseError];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    self.currentXMLContainerTag = elementName;
    if ([elementName isEqualToString:RSSItemTag]) {
        _parserIsWithinItemTag = YES;
        self.feedItemDataContainer = [self generateFeedItemContainer];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:RSSItemTag]) {
        _parserIsWithinItemTag = NO;
        if (self.feedItemDataContainer != nil) {
            Item * feedItem = [self.feedService feedItemFromDictionary:self.feedItemDataContainer];
            if (feedItem != nil) {
                [self.rssFeed addItemsObject:feedItem];
            }
        }
        self.feedItemDataContainer = nil;
    }
    
    self.currentXMLContainerTag = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_parserIsWithinItemTag) {
        [self handleRSSItemStringContent:string];
    }
    else {
        [self handleRSSFeedStringContent:string];
    }
}

- (void)handleRSSItemStringContent:(NSString*)tagContent {
    NSString * key = RSSTitleTag;
    
    if ([self.currentXMLContainerTag isEqualToString:RSSLinkTag]) {
        key = RSSLinkTag;
    }
    else if ([self.currentXMLContainerTag isEqualToString:RSSDescriptionTag]) {
        key = RSSDescriptionTag;
    }
    else if ([self.currentXMLContainerTag isEqualToString:RSSDateTag]) {
        key = RSSDateTag;
    }
    
    NSString * currentcontent = [self.feedItemDataContainer valueForKey:key];
    [self.feedItemDataContainer setValue:[currentcontent stringByAppendingString:tagContent] forKey:key];
}

- (void)handleRSSFeedStringContent:(NSString*)tagContent {
    if ([self.currentXMLContainerTag isEqualToString:RSSTitleTag]) {
        if (self.rssFeed.title != nil) {
            self.rssFeed.title = [self.rssFeed.title stringByAppendingString:tagContent];
        }
        else {
            self.rssFeed.title = tagContent;
        }
    }
    else if ([self.currentXMLContainerTag isEqualToString:RSSDescriptionTag]) {
        if (self.rssFeed.descriptionStr != nil) {
            self.rssFeed.descriptionStr = [self.rssFeed.descriptionStr stringByAppendingString:tagContent];
        }
        else {
            self.rssFeed.descriptionStr = tagContent;
        }
    }
}

- (NSDictionary*)generateFeedItemContainer {
    NSDictionary * container = [[NSDictionary alloc] init];
    [container setValue:@"" forKey:RSSTitleTag];
    [container setValue:@"" forKey:RSSLinkTag];
    [container setValue:@"" forKey:RSSDescriptionTag];
    [container setValue:@"" forKey:RSSDateTag];
    return container;
}

@end
