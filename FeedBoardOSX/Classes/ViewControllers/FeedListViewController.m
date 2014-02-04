//
//  FeedListViewController.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 04/02/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "FeedListViewController.h"

@interface FeedListViewController () {
    __weak IBOutlet NSButton * _addFeedButton;
    __weak IBOutlet NSButton * _deleteFeedButton;
}

@end

@implementation FeedListViewController

#pragma mark - UI Actions

- (IBAction)addButtonPressed:(id)sender {
    NSLog(@"Add Button Pressed");
}

- (IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Delete Button Pressed");
}

@end
