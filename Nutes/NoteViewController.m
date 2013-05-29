//
//  NoteViewController.m
//  Nutes
//
//  Created by Andrew Melis on 5/29/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import "NoteViewController.h"
#import "NSString+Now.h"
#import "AllNotesViewController.h"


@interface NoteViewController ()

@end

@implementation NoteViewController


@synthesize linkedAccount = _linkedAccount;
@synthesize fileSystem = _fileSystem;
@synthesize noteTextView = _noteTextView;
@synthesize path = _path;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"%@",_path.name);
    if(_path!= nil) {
        DBFile* file;
        file = [self oldFile:file];
        NSString *contents = [file readString:nil];
        _noteTextView.text = contents;  //display old text
    }
    
    
    
//    _linkedAccount = [[DBAccountManager sharedManager] linkedAccount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    
    [_noteTextView resignFirstResponder];
    
    
    
    //sync with user after create first note
    [self linkAccount];
    
    

    DBFile *file;
    if (_path == nil) {
        file = [self newFile:file];
    }
    else{
        file = [self oldFile:file];
    }
    
    NSString *newNoteText = [NSString stringWithFormat:@"%@", _noteTextView.text];
    
    [file writeString:newNoteText error:nil];
    
    [file update:nil];
    

}

-(void)linkAccount
{
    _linkedAccount = [[DBAccountManager sharedManager] linkedAccount];
    if (_linkedAccount == nil) {
        [[DBAccountManager sharedManager] linkFromController:self];
        _linkedAccount = [[DBAccountManager sharedManager] linkedAccount];
    }
    
    //get filesystem
    
    if([DBFilesystem sharedFilesystem]) {
        _fileSystem = [DBFilesystem sharedFilesystem];
    }
    else {
        //create DBFileSystem
        _fileSystem = [[DBFilesystem alloc] initWithAccount:_linkedAccount];
        [DBFilesystem setSharedFilesystem:_fileSystem];
    }
    
}


-(DBFile*)newFile: (DBFile*) file
{
    NSString *now = @"";
    DBPath *newPath = [[DBPath root] childPath:[now getCurrentTimeString:now]];
    file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
    return file;
}

-(DBFile*)oldFile: (DBFile*)  file
{
    file = [[DBFilesystem sharedFilesystem] openFile:_path error:nil];
    return file;
}

- (IBAction)allNotesButton:(UIBarButtonItem *)sender {

}

- (IBAction)cameraButton:(UIBarButtonItem *)sender {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]==YES) {
        //create image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        //Set source to the camera
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        //delegate is self
        imagePicker.delegate = self;
        
        //show image picker
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        //device has no camera
        //look into this later
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        [self linkAccount];
    
    if ([segue.identifier isEqualToString:@"allNoteSegue"]) {
        
        AllNotesViewController *controllerForSegue;
        controllerForSegue = segue.destinationViewController;
        
    }
}


//dealing with photos
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //access the uncropped image from info dictioanry
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //dismiss controller
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 640));
    [image drawInRect:CGRectMake(0, 0, 640, 640)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Upload Image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
//    [self uploadImages:imageData];
}


@end
