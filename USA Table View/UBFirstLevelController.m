//
//  UBFirstLevelControllerViewController.m
//  USA Table View
//
//  Created by R Auradkar on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UBFirstLevelController.h"
#import "UBDetailViewController.h"
#import "UBStates.h"

@interface UBFirstLevelController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray* stateNamesData;
@property (strong, nonatomic) NSArray* stateDetailData;
@property (strong, nonatomic) NSArray *indices;

@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (strong, nonatomic) NSArray *filteredListContent;
@property (assign, nonatomic) BOOL searching;
@property (assign, nonatomic) BOOL canSelectRow;

@property (assign, nonatomic) NSArray *namesArray;

- (void) doneSearching: (id)sender;
- (void) searchTableView;

@end

@implementation UBFirstLevelController

@synthesize tableView = _tableView;
@synthesize stateNamesData = _stateNamesData;
@synthesize stateDetailData = _stateDetailData;
@synthesize indices = _indices;

@synthesize searchDisplayController;
@synthesize filteredListContent;
@synthesize searching;
@synthesize canSelectRow;

@synthesize namesArray;

#pragma mark - initializations of data source arrays

- (NSArray *) indices {
    if (_indices == nil) {
        NSArray *content = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E",
                            @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", 
                            @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
        _indices = content;
    }
    return _indices;
    
}

- (NSArray*) stateNamesData {
	if ( _stateNamesData == nil ) {
       UBStates *states = [[UBStates alloc] init];
        NSArray *dataArray = [NSArray arrayWithArray:[states getDataForMainTable]];
        _stateNamesData = dataArray;
    }
	return [_stateNamesData copy];
}

- (NSArray*) stateDetailData {
	if ( _stateDetailData == nil ) {
       UBStates *states = [[UBStates alloc] init];
        NSArray *dataArray = [[NSArray alloc] initWithArray:[states stateSpecificData]];
        _stateDetailData = dataArray;
	}
	return _stateDetailData;
}

#pragma mark - manage memory and view methods

- (void)dealloc {
    [self.searchDisplayController release];
    [self.stateDetailData release];
    [self.stateNamesData release];
    [self.filteredListContent release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"States";
    searching = NO;
    canSelectRow = YES;
}

- (void)viewDidUnload
{
    self.stateNamesData = nil;
    self.stateDetailData = nil;
    self.filteredListContent = nil;
    self.searchDisplayController = nil;
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections
    if (searching)
        return 1;
    else
        return [self.indices count];    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredListContent count];
    } 
    else {
        NSUInteger rowsInSection;
        
        NSString *myLetter = [self.indices objectAtIndex:section];
        
        if ([myLetter isEqualToString:@"Z"]) {
            rowsInSection = 0;
        }
        else {
            NSString *myNextLetter = [self.indices objectAtIndex:section + 1];
            
            NSInteger row = [self.stateNamesData indexOfObject:myLetter];
            NSInteger nextrow = [self.stateNamesData indexOfObject:myNextLetter];
            
            rowsInSection = (nextrow - 1) - row;
        }
        return rowsInSection;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    NSString *myLetter = [self.indices objectAtIndex:section];    
    NSUInteger mySection;
    mySection = [self.stateNamesData indexOfObject:myLetter];
    NSUInteger myRow;
    
    if (row == 0) 
        myRow = mySection + 1;
    else {
        myRow = mySection + row + 1;
    }
    
    static NSString *StateListCellIdentifier = @"StateListCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StateListCellIdentifier];
    
    // Configure the cell...    
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:StateListCellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *stateName = [[self.filteredListContent objectAtIndex:row] valueForKey:@"name"];
        NSString *imagePath;
        imagePath = [[self.filteredListContent objectAtIndex:row] valueForKey:@"image"];
        
        cell.imageView.image = [UIImage imageNamed:imagePath];
        cell.textLabel.text = stateName;
        cell.detailTextLabel.text = [[self.filteredListContent objectAtIndex:row] valueForKey:@"capital"];
    }
    else {        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *stateName = [[self.stateNamesData objectAtIndex:myRow] valueForKey:@"image"];        
        NSString *imagePath = [[[NSString alloc] initWithString:stateName] autorelease];
        UIImage *smallFlagImg = [UIImage imageNamed:imagePath];
        
        cell.imageView.image = smallFlagImg;
        cell.textLabel.text = [[self.stateNamesData objectAtIndex:myRow] valueForKey:@"name"];
        cell.detailTextLabel.text = [[self.stateNamesData objectAtIndex:myRow] valueForKey:@"capital"];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSUInteger row = [indexPath row];
        NSUInteger section = [indexPath section];
        
        NSString *currentLetter = [self.indices objectAtIndex:section];
        NSUInteger currentSection, nextSection;
    
      if (searching) {
          NSString *searchName = [[self.filteredListContent objectAtIndex:row] valueForKey:@"name"];
          currentLetter = [searchName substringToIndex:1];
          NSInteger currentLetterIndex = [self.indices indexOfObject:currentLetter];
          NSString *nextLetter = [self.indices objectAtIndex:(currentLetterIndex+1)];
          currentSection = [self.stateNamesData indexOfObject:currentLetter];
          nextSection = [self.stateNamesData indexOfObject:nextLetter];
         
          for (NSUInteger i = currentSection; i < nextSection; i++) {      
              row = i;
              NSString *name = [[self.stateDetailData objectAtIndex:(row + 1)] valueForKey:@"name"];
              
              NSRange textRange;
              textRange =[[name lowercaseString] rangeOfString:[searchName lowercaseString]];
              
              if(textRange.location != NSNotFound)
              {
                  UBDetailViewController *childController = [[UBDetailViewController alloc] initWithNibName:@"UBDetailViewController" bundle:nil];
                  
                  // Initialize the child controller with the data that it needs to work with. This is the table
                  // with state detail information
                  [childController stateDetailData:[self.stateDetailData objectAtIndex:(row + 1)]];
                  
                  NSString *name = [[self.stateDetailData objectAtIndex:(row + 1)] valueForKey:@"name"];
                  childController.title = name;
                  
                  [self.navigationController pushViewController:childController animated:YES];
                  [childController release];
                  break;
              }              
          }
    }
    else {
       currentSection = [self.stateNamesData indexOfObject:currentLetter];
        NSUInteger myRow;
        
        if (row == 0) 
            myRow = currentSection + 1;
        else {
            myRow = currentSection + row + 1;
        }
        
        UBDetailViewController *childController = [[UBDetailViewController alloc] initWithNibName:@"UBDetailViewController" bundle:nil];
        
        // Initialize the child controller with the data that it needs to work with. This is the table
        // with state detail information
        [childController stateDetailData:[self.stateDetailData objectAtIndex:myRow]];
        
        NSString *name = [[self.stateDetailData objectAtIndex:myRow] valueForKey:@"name"];
        childController.title = name;
        
        [self.navigationController pushViewController:childController animated:YES];
        [childController release];
    }
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if (searching)
        return nil;
    else
        return self.indices;
}

/*- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
  
    NSLog(@"indices indexofobject:title %d, %d", index, [indices indexOfObject:title]);
    
    return [indices indexOfObject:title];
} */

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    
    if (searching)
       return nil;
    else
        return ([self.indices objectAtIndex:section]);
    
}

#pragma mark search related table methods

//---fired before a row is selected---
- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (canSelectRow)
        return indexPath;
    else
        return nil;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    UBStates *usaStates = [[[UBStates alloc] init] autorelease];
    NSArray *names = [usaStates stateDictionaries];
  
   NSPredicate *resultPredicate = [NSPredicate
                                   predicateWithFormat:@"(name contains[cd] %@)",
                                   searchText];
    
    self.filteredListContent = [names filteredArrayUsingPredicate:resultPredicate];
    
}

- (BOOL) searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
	[self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController*)controller {
	self.searching = YES;    
    UBStates *usaStates = [[[UBStates alloc] init] autorelease];
	self.filteredListContent = [usaStates getStateNames];
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController*)controller {
	self.filteredListContent = nil;
	self.searching = NO;
}


@end
