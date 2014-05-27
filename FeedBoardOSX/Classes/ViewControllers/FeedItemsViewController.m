//
//  FeedItemsViewController.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 04/02/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "FeedItemsViewController.h"

@interface FeedItemsViewController () {
}

@property NSInteger sliderInt;

@end

@implementation FeedItemsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        [self.view setLayer:[[CALayer alloc] init]];
        [self.view setWantsLayer:YES];
        self.view.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    }
    return self;
}

@end
