//
//  FeedBoardWindow.h
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 04/02/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FeedBoardWindow : NSWindow

@property (weak, nonatomic) IBOutlet NSView * feedListView;
@property (weak, nonatomic) IBOutlet NSView * feedItemsListView;
@property (weak, nonatomic) IBOutlet NSView * feedItemView;

@property (weak, nonatomic) IBOutlet NSSplitView * mainHorizontalSplitView;
@property (weak, nonatomic) IBOutlet NSSplitView * secondaryVerticalSplitView;

@end
