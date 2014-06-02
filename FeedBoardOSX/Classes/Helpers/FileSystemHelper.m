//
//  FileSystemHelper.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 02/06/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "FileSystemHelper.h"

NSString * const dbDirectory = @"Data";

@implementation FileSystemHelper

+ (NSURL*)applicationDirectory {
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
    NSArray* urlPaths = [fileManager URLsForDirectory:NSApplicationSupportDirectory
                                            inDomains:NSUserDomainMask];
    
    NSURL* appDirectory = [[urlPaths objectAtIndex:0] URLByAppendingPathComponent:bundleID isDirectory:YES];
    
    if (![fileManager fileExistsAtPath:[appDirectory path]]) {
        [fileManager createDirectoryAtURL:appDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return appDirectory;
}

+ (NSURL*)dataBaseDirectory {
    NSURL * appDirectory = [FileSystemHelper applicationDirectory];
    NSURL * dbDirectoryURL = [appDirectory URLByAppendingPathComponent:dbDirectory];
    
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    
    if (![fileManager fileExistsAtPath:[dbDirectoryURL path]]) {
        [fileManager createDirectoryAtURL:dbDirectoryURL withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return dbDirectoryURL;
}

@end
