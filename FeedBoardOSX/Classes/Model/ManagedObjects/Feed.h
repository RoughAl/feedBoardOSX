//
//  Feed.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 02/06/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Item;

@interface Feed : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descriptionStr;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) Category *category;
@end

@interface Feed (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
