//
//  AppDelegate.h
//  FeedBoardOSX
//
//  Created by Viktor Jenei on 03/02/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FeedBoardWindow;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet FeedBoardWindow *window;

@end
