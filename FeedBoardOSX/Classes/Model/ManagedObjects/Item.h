//
//  Item.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 02/06/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descriptionStr;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSDate * publicationDate;
@property (nonatomic, retain) NSManagedObject *feed;

@end
