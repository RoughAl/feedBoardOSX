//
//  StringHelper.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 08/07/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringHelper : NSObject

+ (NSDate*)dateFromRSSDateString:(NSString*)dateString;
+ (BOOL)isUrlStringValid:(NSString*)urlString;
+ (NSString*)stripHTMLTagsFromString:(NSString*)string;

@end
