//
//  FileSystemHelper.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 02/06/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSystemHelper : NSObject

+ (NSURL*)applicationDirectory;
+ (NSURL*)dataBaseDirectory;

@end
