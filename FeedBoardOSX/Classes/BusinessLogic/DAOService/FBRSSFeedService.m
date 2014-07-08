//
//  FBRSSFeedService.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 08/07/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "FBRSSFeedService.h"
#import "Feed.h"
#import "Item.h"
#import "FBRSSFeedParser.h"
#import "StringHelper.h"

#pragma mark - Base Class Extension

@interface FBRSSFeedService ()

@property (strong, nonatomic) NSManagedObjectContext * context;

@end

#pragma mark - Constants

NSString * const FeedModelName = @"Feed";
NSString * const FeedItemModelName = @"Item";

@implementation FBRSSFeedService

+ (instancetype)feedServiceWithManagedObjectContext:(NSManagedObjectContext*)context {
    return [[FBRSSFeedService alloc] initWithManagedObjectContext:context];
}

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)context {
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (Feed*)feed {
    Feed * aFeed = [NSEntityDescription insertNewObjectForEntityForName:FeedModelName inManagedObjectContext:self.context];
    return aFeed;
}

- (Feed*)feedWithURLString:(NSString*)urlString {
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:FeedModelName];
    request.predicate = [NSPredicate predicateWithFormat:@"link = '%@'", urlString];
    
    NSArray * result = [self.context executeFetchRequest:request error:nil];
    
    return result.firstObject != nil ? result.firstObject : [self feed];
}

- (Item*)feedItem {
    Item * anItem = [NSEntityDescription insertNewObjectForEntityForName:FeedItemModelName inManagedObjectContext:self.context];
    return anItem;
}

- (Item*)feedItemWithURLString:(NSString*)urlString {
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:FeedItemModelName];
    request.predicate = [NSPredicate predicateWithFormat:@"link = '%@'", urlString];
    
    NSArray * result = [self.context executeFetchRequest:request error:nil];
    
    return result.firstObject != nil ? result.firstObject : [self feedItem];
}

- (Item*)feedItemFromDictionary:(NSDictionary*)dictionary {
    NSString * urlString = [dictionary objectForKey:RSSLinkTag];
    Item * item = nil;
    if (urlString != nil && urlString.length > 0) {
        item = [self feedItemWithURLString:urlString];
        item.link = urlString;
        
        NSString * title = [dictionary objectForKey:RSSTitleTag];
        NSString * desc = [dictionary objectForKey:RSSDescriptionTag];
        NSString * date = [dictionary objectForKey:RSSDateTag];
        
        item.title = title != nil ? title : @"";
        item.descriptionStr = desc != nil ? desc : @"";
        item.publicationDate = [StringHelper dateFromRSSDateString:date];
        
    }
    return nil;
}

@end
