//
//  UBDetailViewController.m
//  USA Table View
//
//  Created by R Auradkar on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UBDetailViewController.h"

@interface UBDetailViewController ()

@property (strong, nonatomic) NSArray* stateDetailArray;

@end

@implementation UBDetailViewController
@synthesize rowDetail;
@synthesize bigStateFlag;
@synthesize footerText;
@synthesize stateDetailArray;

- (void) stateDetailData: (NSArray *) detailArray {
    stateDetailArray = detailArray;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.  
        
}

- (void)viewDidUnload
{
    [self setRowDetail:nil];
    [self setBigStateFlag:nil];
    [self setFooterText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows;
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            rows = 2;
            break;
        case 1:
            rows = 1;
            break;
        case 2:
            rows = 2;
            break;
        default:
            rows = 0;
            break;
    };
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *StateDetailCellIdentifier = @"StateDetailCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StateDetailCellIdentifier];
    
    [bigStateFlag setImage:[UIImage imageNamed:[stateDetailArray valueForKey:@"image"]]];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:StateDetailCellIdentifier] autorelease];
        
        NSUInteger section = [indexPath section];
        NSUInteger row = [indexPath row];
        
        NSString *label = @"bad data";
        NSString *detail = @"bad data";
        
        switch (section) {
            case 0:
                switch (row) {
                    case 0:
                        label = @"Capital";
                        detail = [stateDetailArray valueForKey:@"capital"];
                        break;
                    case 1:
                        label  = @"Biggest City";
                        detail = [stateDetailArray valueForKey:@"populousCity"];
                        break;
                    default:
                        break;
                }
                break;
            case 1:
                label = @"Statehood";
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MMMM d, yyyy"];
                detail = [dateFormatter stringFromDate:[stateDetailArray valueForKey:@"date"]];
                [dateFormatter release];
                break;
            case 2:
                switch (row) {
                    case 0:
                        label = @"Area (sq. mi.)";
                        NSNumber *areaNumber = [stateDetailArray valueForKey:@"area"];
                        NSNumberFormatter *areaFormatter = [[NSNumberFormatter alloc] init];
                        detail = [areaFormatter stringForObjectValue:areaNumber];
                        [areaFormatter release];
                        break;
                    case 1:
                        label = @"Population";
                        NSNumber *popNumber = [stateDetailArray valueForKey:@"population"];
                        NSNumberFormatter *popFormatter = [[NSNumberFormatter alloc] init];
                        [popFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                        detail = [popFormatter stringForObjectValue:popNumber];
                        [popFormatter release];
                        break;
                    default:
                        break;
                };
                break;
            default:
                break;
        }
        
        cell.textLabel.text = label;
        cell.detailTextLabel.text = detail;
    }
    
    return cell;
}

- (void)dealloc {
    [rowDetail release];
    [bigStateFlag release];
    [footerText release];
    [super dealloc];
}
@end
