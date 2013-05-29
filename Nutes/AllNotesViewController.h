//
//  AllNotesViewController.h
//  Nutes
//
//  Created by Andrew Melis on 5/29/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <dropbox/dropbox.h>


@interface AllNotesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *allNotes;
@property (nonatomic, readonly) DBAccount *linkedAccount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)composeButton:(UIBarButtonItem *)sender;

@end
