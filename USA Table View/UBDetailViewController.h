//
//  UBDetailViewController.h
//  USA Table View
//
//  Created by R Auradkar on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *rowDetail;
@property (retain, nonatomic) IBOutlet UIImageView *bigStateFlag;
@property (retain, nonatomic) IBOutlet UILabel *footerText;

- (void) stateDetailData: (NSArray *) detailArray;


@end
