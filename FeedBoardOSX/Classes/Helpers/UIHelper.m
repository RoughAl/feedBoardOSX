//
//  UIHelper.m
//  FeedBoardOSX
//
//  Created by Jenei Viktor on 04/02/14.
//  Copyright (c) 2014 Viktor Jenei. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+ (void)addFillConstraintsToView:(NSView*)aChildView forSuperView:(NSView*)aParentView {
    [aChildView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint * aWidthConstraint = [NSLayoutConstraint constraintWithItem:aChildView
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:aParentView
                                                                         attribute:NSLayoutAttributeWidth
                                                                        multiplier:1.0
                                                                          constant:0];
    
    NSLayoutConstraint * aHeightConstraint = [NSLayoutConstraint constraintWithItem:aChildView
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:aParentView
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:1.0
                                                                           constant:0];
    [aParentView addConstraints:@[aWidthConstraint, aHeightConstraint]];
    
}
@end
