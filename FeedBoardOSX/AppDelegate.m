//
//  AppDelegate.m
//  FeedBoardOSX
//
//  Created by Viktor Jenei on 03/02/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedBoardWindow.h"
#import "FeedListViewController.h"
#import "FeedItemsViewController.h"
#import "FeedItemViewController.h"
#import "UIHelper.h"

@interface AppDelegate ()

@property (strong, nonatomic) FeedListViewController * feedListViewController;
@property (strong, nonatomic) FeedItemsViewController * feedItemsListViewController;
@property (strong, nonatomic) FeedItemViewController * feedItemViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setUpControllers];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)setUpControllers {
    _feedListViewController = [[FeedListViewController alloc] initWithNibName:@"FeedListView" bundle:nil];
    [self.window.feedListView addSubview:_feedListViewController.view];
    _feedListViewController.view.frame = self.window.feedListView.bounds;
    [UIHelper addFillConstraintsToView:_feedListViewController.view forSuperView:self.window.feedListView];

    _feedItemsListViewController = [[FeedItemsViewController alloc] initWithNibName:@"FeedItemsListView" bundle:nil];
    [self.window.feedItemsListView addSubview:_feedItemsListViewController.view];
    _feedItemsListViewController.view.frame = self.window.feedItemsListView.bounds;
    [UIHelper addFillConstraintsToView:_feedItemsListViewController.view forSuperView:self.window.feedItemsListView];
    
    _feedItemViewController = [[FeedItemViewController alloc] initWithNibName:@"FeedItemView" bundle:nil];
    [self.window.feedItemView addSubview:_feedItemViewController.view];
    _feedItemViewController.view.frame = self.window.feedItemView.bounds;
    [UIHelper addFillConstraintsToView:_feedItemViewController.view forSuperView:self.window.feedItemView];
    
}

@end
