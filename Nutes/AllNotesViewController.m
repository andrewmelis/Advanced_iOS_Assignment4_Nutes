//
//  AllNotesViewController.m
//  Nutes
//
//  Created by Andrew Melis on 5/29/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import "AllNotesViewController.h"
#import "NoteViewController.h"
#import <dropbox/dropbox.h>


@interface AllNotesViewController ()

@end

@implementation AllNotesViewController
{
    DBPath *pathForSegue;
    
}

@synthesize allNotes = _allNotes;
@synthesize linkedAccount = _linkedAccount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _linkedAccount = [[DBAccountManager sharedManager] linkedAccount];
    _allNotes = [self populateNotes];

}

-(NSArray*) populateNotes
{
    DBFilesystem *fileSystem = [DBFilesystem sharedFilesystem];
    return [fileSystem listFolder:[DBPath root] error:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allNotes.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *noteCellIdentifier = @"noteCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noteCellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noteCellIdentifier];
    }
    
    
    //need to call .name function of object at indexpath
    
    DBFileInfo *info = [_allNotes objectAtIndex:indexPath.row];
//    DBFile *file = [[DBFilesystem sharedFilesystem] open:info.path error:nil];
    
    cell.textLabel.text = info.path.name;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"clicked on note at index %i",indexPath.item);
//    NSLog(@"what the hell kind of object is this %@",[_allNotes objectAtIndex:indexPath.item]);
//    
//    DBFileInfo *info = [_allNotes objectAtIndex:indexPath.row];
//    pathForSegue = info.path;
//    
////    [self performSegueWithIdentifier:@"noteDetailSegue" sender:info];
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"what the hell kind of object is this %@",sender);
    
    NoteViewController *controllerForSegue;
    controllerForSegue = segue.destinationViewController;   //all segues want this
    
    if([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        if ([segue.identifier isEqualToString:@"noteDetailSegue"]) {

            DBFileInfo *info = [_allNotes objectAtIndex:indexPath.row];
            
            pathForSegue = info.path;
            NSLog(@"%@",pathForSegue.name);
            controllerForSegue.path = pathForSegue;
        }
        
    }
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)composeButton:(UIBarButtonItem *)sender {
}
@end
