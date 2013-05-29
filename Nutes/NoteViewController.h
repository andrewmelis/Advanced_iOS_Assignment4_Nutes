//
//  NoteViewController.h
//  Nutes
//
//  Created by Andrew Melis on 5/29/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <dropbox/dropbox.h>

@interface NoteViewController : UIViewController

- (IBAction)doneButton:(UIBarButtonItem *)sender;
- (IBAction)allNotesButton:(UIBarButtonItem *)sender;
- (IBAction)cameraButton:(UIBarButtonItem *)sender;

@property (nonatomic, readonly) DBAccount *linkedAccount;
@property (nonatomic, readonly) DBFilesystem *fileSystem;
@property (nonatomic, strong) DBPath *path;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@end
