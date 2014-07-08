//
//  StringHelper.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 08/07/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "StringHelper.h"

@implementation StringHelper

+ (NSDate*)dateFromRSSDateString:(NSString*)dateString {
    if (dateString == nil) {
        return [NSDate date];
    }
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE, d MMM yyyy HH:mm:ss Z";
    
    NSDate * date = [formatter dateFromString:dateString];
    if (date == nil) {
        date = [NSDate date];
    }
    
    return date;
}

+ (BOOL)isUrlStringValid:(NSString*)urlString {
    BOOL result = NO;
    if ([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
        NSURL * testUrl = [NSURL URLWithString:urlString];
        if (testUrl != nil) {
            result = YES;
        }
    }
    return result;
}

+ (NSString*)stripHTMLTagsFromString:(NSString*)string {
    NSString * resultStr = string;
    
    if ([string length] > 0) {
        NSError * error = nil;
        NSRegularExpression * regExp = [[NSRegularExpression alloc] initWithPattern:@"<[^>]+>" options:NSRegularExpressionCaseInsensitive error:&error];
        if (!error) {
            resultStr = [regExp stringByReplacingMatchesInString:resultStr options:NSMatchingReportProgress range:NSMakeRange(0, resultStr.length) withTemplate:@""];
            resultStr = [resultStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    }
    
    return resultStr;
}

@end
