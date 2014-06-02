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
    
    __weak IBOutlet NSPanel * _addFeedPanel;
    __weak IBOutlet NSTextField * _addFeedTextField;
    __weak IBOutlet NSButton * _addFeedPanelAddButton;
    __weak IBOutlet NSButton * _addFeedPanelCancelButton;
    
    __weak IBOutlet NSTableView * _feedsTableView;
}

@end

@implementation FeedListViewController

#pragma mark - UI Actions

- (IBAction)addButtonPressed:(id)sender {
    NSLog(@"Add Button Pressed");
    [NSApp beginSheet:_addFeedPanel
       modalForWindow:self.view.window
        modalDelegate:self
       didEndSelector:nil
          contextInfo:nil];
    NSString * pasteBoardURL = [self getPasteBoardUrlString];
    _addFeedTextField.stringValue = pasteBoardURL != nil ? pasteBoardURL : @"";
}

- (IBAction)deleteButtonPressed:(id)sender {
    NSLog(@"Delete Button Pressed (#%ld)", (long)[_feedsTableView selectedRow]);
}

- (IBAction)addFeedPanelEnded:(id)sender {
    [NSApp endSheet:_addFeedPanel];
    [_addFeedPanel orderOut:sender];
    if ([sender isEqual:_addFeedPanelAddButton]) {
        NSLog(@"Feed url received: %@", [_addFeedTextField stringValue]);
    }
}

#pragma mark - PasteBoard utility Methods

- (NSString*)getPasteBoardUrlString {
    NSString * clipBoardURLContent;
    
    NSPasteboard * pasteBoard = [NSPasteboard generalPasteboard];
    NSArray *classes = [[NSArray alloc] initWithObjects:[NSString class], nil];
    
    BOOL ok = [pasteBoard canReadObjectForClasses:classes options:nil];
    if (ok) {
        NSArray *copiedItems = [pasteBoard readObjectsForClasses:classes options:nil];
        if ([copiedItems count]) {
            NSString * clipBoardStringContent = [copiedItems firstObject];
            NSURL * testURL = [NSURL URLWithString:clipBoardStringContent];
            if (testURL != nil) {
                clipBoardURLContent = [testURL absoluteString];
            }
        }
    }
    
    return clipBoardURLContent;
}

#pragma mark - NSTableViewDataSource methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 3;
}

#pragma mark - NSTableViewDelegate methods

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *result = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    result.textField.stringValue = @"Sallala";
    return result;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex {
    NSLog(@"Row at index #%ld selected", (long)rowIndex);
    return YES;
}

@end
