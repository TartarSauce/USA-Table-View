//
//  UBStates.h
//  USA Table View
//
//  Created by R Auradkar on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UBStates : NSObject

- (NSArray *) getDataForMainTable;
- (NSArray *) stateSpecificData;
- (NSArray *) getStateNames;
- (NSArray *) stateDictionaries;

@end
