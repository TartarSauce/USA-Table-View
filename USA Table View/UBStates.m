//
//  UBStates.m
//  USA Table View
//
//  Created by R Auradkar on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UBStates.h"

@interface UBStates ()

@property (strong, nonatomic) NSArray *stateArray;
@property (strong, nonatomic) NSArray *stateDetailArray;
@property (strong, nonatomic) NSString *smallFlagPath;
@property (strong, nonatomic) NSArray *bigFlagArray;

@end

@implementation UBStates

@synthesize stateArray;
@synthesize smallFlagPath;
@synthesize bigFlagArray;
@synthesize stateDetailArray;

- (void) dealloc {
    [stateArray dealloc];
    [stateDetailArray dealloc];
    [smallFlagPath dealloc];
    [bigFlagArray dealloc];
    [super dealloc];
}

- (NSArray *) stateDictionaries {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"plist"];
    
    NSArray *arrayOfDicts = [[[NSArray alloc] initWithContentsOfFile:path] autorelease];
    self.stateArray = arrayOfDicts;
    
    NSMutableArray *dictArray = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary *d in stateArray) {
        // dictionary
        NSMutableDictionary *row = [[[NSMutableDictionary alloc] init] autorelease];
        
        // obtain source data
        NSString *name = [d objectForKey:@"name"];
        NSString *abbreviation = [d objectForKey:@"abbreviation"];
        NSDate *date = [d objectForKey:@"date"];
        NSNumber *area = [d objectForKey:@"area"];
        NSNumber *population = [d objectForKey:@"population"];
        NSString *capital = [d objectForKey:@"capital"];
        NSString *populousCity = [d objectForKey:@"populousCity"];
        
        //Manipulate the state name data to get the name of the image flag
        NSString *stateName = [[[NSString alloc] initWithString:name] autorelease];
        NSString *newString = [stateName stringByReplacingOccurrencesOfString:@" " withString:@"_"];    
        NSMutableString *lowerCase = [[[NSMutableString alloc] initWithString:[newString lowercaseString]] autorelease];
        [lowerCase appendString:@"-50.png"];  
        NSMutableString *finalImageName = [[[NSMutableString alloc] initWithString:@"50/"] autorelease];
        [finalImageName appendString:lowerCase];
        NSString *path = [[[NSString alloc] initWithString:finalImageName] autorelease];
        
        // package the data into a format that can be consumed by the main state table
        [row setValue:path forKey:@"image"];
        [row setValue:name forKey:@"name"];
        [row setValue:abbreviation forKey:@"abbreviation"];
        [row setValue:date forKey:@"date"];
        [row setValue:area forKey:@"area"];
        [row setValue:population forKey:@"population"];
        [row setValue:capital forKey:@"capital"];
        [row setValue:populousCity forKey:@"populousCity"];
        
        [dictArray addObject:row];
    }
   // NSLog(@"my dictionary is %@", dictArray);
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name"
                                                  ascending:NO] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [dictArray sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

- (NSArray *) getDataForMainTable
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"plist"];
    
    NSArray *arrayOfDicts = [[[NSArray alloc] initWithContentsOfFile:path] autorelease];
    self.stateArray = arrayOfDicts;
    
    NSMutableArray *content = [[[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E",
                             @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", 
                            @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil] autorelease];
    
    NSMutableArray *dictArray = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary *d in stateArray) {
        // dictionary
        NSMutableDictionary *row = [[[NSMutableDictionary alloc] init] autorelease];
        
        // obtain source data
        NSString *name = [d objectForKey:@"name"];
        NSString *alphabetForIndex = [name substringToIndex:1];
        NSString *abbreviation = [d objectForKey:@"abbreviation"];
        NSDate *date = [d objectForKey:@"date"];
        NSNumber *area = [d objectForKey:@"area"];
        NSNumber *population = [d objectForKey:@"population"];
        NSString *capital = [d objectForKey:@"capital"];
        NSString *populousCity = [d objectForKey:@"populousCity"];
        
        //Manipulate the state name data to get the name of the image flag
        NSString *stateName = [[[NSString alloc] initWithString:name] autorelease];
        NSString *newString = [stateName stringByReplacingOccurrencesOfString:@" " withString:@"_"];    
        NSMutableString *lowerCase = [[[NSMutableString alloc] initWithString:[newString lowercaseString]] autorelease];
        [lowerCase appendString:@"-50.png"];  
        NSMutableString *finalImageName = [[[NSMutableString alloc] initWithString:@"50/"] autorelease];
        [finalImageName appendString:lowerCase];
        NSString *path = [[[NSString alloc] initWithString:finalImageName] autorelease];
      
        // package the data into a format that can be consumed by the main state table
        [row setValue:alphabetForIndex forKey:@"headerTitle"];
        [row setValue:path forKey:@"image"];
        [row setValue:name forKey:@"name"];
        [row setValue:abbreviation forKey:@"abbreviation"];
        [row setValue:date forKey:@"date"];
        [row setValue:area forKey:@"area"];
        [row setValue:population forKey:@"population"];
        [row setValue:capital forKey:@"capital"];
        [row setValue:populousCity forKey:@"populousCity"];
        
        [dictArray addObject:row];
        
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name"
                                                  ascending:NO] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [dictArray sortedArrayUsingDescriptors:sortDescriptors];
    
    for (NSDictionary *d in sortedArray) {
        NSString *letter = [d objectForKey:@"headerTitle"];
        NSUInteger x = [content indexOfObject:letter];
        [content insertObject:d atIndex:(x+1)];
    }
    
    //NSLog(@"Content array is %@", content);
    
    return content;
}


- (NSArray *) stateSpecificData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"plist"];
    
    NSArray *arrayOfDicts = [[[NSArray alloc] initWithContentsOfFile:path] autorelease];
    
    self.stateDetailArray = arrayOfDicts;
    
    
    NSMutableArray *content = [[[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E",
                               @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", 
                               @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil] autorelease ];
    
    NSMutableArray *dictArray = [[[NSMutableArray alloc] init] autorelease];

    for (NSDictionary *d in stateDetailArray) {
        // dictionary
        NSMutableDictionary *row = [[[NSMutableDictionary alloc] init] autorelease];
    
        // get all the state details from source
        NSString *name = [d objectForKey:@"name"];
        NSString *alphabetForIndex = [name substringToIndex:1];        
        NSString *abbreviation = [d objectForKey:@"abbreviation"];
        NSDate *date = [d objectForKey:@"date"];
        NSNumber *area = [d objectForKey:@"area"];
        NSNumber *population = [d objectForKey:@"population"];
        NSString *capital = [d objectForKey:@"capital"];
        NSString *populousCity = [d objectForKey:@"populousCity"];        
        NSString *abbreviationInParens = [@" (" stringByAppendingString:[abbreviation stringByAppendingString:@")"]];
        NSString *nameWithAbbreviation = [name stringByAppendingString:abbreviationInParens];
        
        //create the path for the file name for state big flag image 
        NSString *imageName = [[[NSMutableString alloc] initWithString:name] autorelease];
        NSString *newString = [imageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];    
        NSMutableString *lowerCase = [[[NSMutableString alloc] initWithString:[newString lowercaseString]] autorelease];
        [lowerCase appendString:@"-200.png"];
        NSString *finalPath = [@"200/" stringByAppendingString:lowerCase];
        NSString *path = [[[NSString alloc] initWithString:finalPath] autorelease];
        
        // put everything into the order in the array that we want when we are processing state detail data
        [row setValue:alphabetForIndex forKey:@"headerTitle"];
        [row setValue:path forKey:@"image"];
        [row setValue:nameWithAbbreviation forKey:@"name"];
        [row setValue:date forKey:@"date"];
        [row setValue:area forKey:@"area"];
        [row setValue:population forKey:@"population"];
        [row setValue:capital forKey:@"capital"];
        [row setValue:populousCity forKey:@"populousCity"];
        
        [dictArray addObject:row];
        
    }
    
    // Alphabetically order the data based on the state name
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name"
                                                  ascending:NO] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [dictArray sortedArrayUsingDescriptors:sortDescriptors];
    
    for (NSDictionary *d in sortedArray) {
        NSString *letter = [d objectForKey:@"headerTitle"];
        NSUInteger x = [content indexOfObject:letter];
        [content insertObject:d atIndex:(x+1)];
    }
    
    NSLog(@"Content array is %@", content);
    return content;
        
}

- (NSArray *) getStateNames
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"plist"];
    
    NSArray *arrayOfDicts = [[[NSArray alloc] initWithContentsOfFile:path] autorelease];
    
    self.stateArray = arrayOfDicts;
    
    NSMutableArray *nameArray = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary *d in stateArray) {
        NSString *name = [d objectForKey:@"name"];
        [nameArray addObject:name];
    }
    
    NSLog(@"state names are %@", nameArray);
    return nameArray;
    
}

@end
