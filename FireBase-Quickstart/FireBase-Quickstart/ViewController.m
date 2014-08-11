//
//  ViewController.m
//  FireBase-Quickstart
//
//  Created by yiqin on 8/11/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create a reference to a Firebase location
    Firebase* ref = [[Firebase alloc] initWithUrl:@"https://quickstart.firebaseio.com/"];
    // Write data to Firebase
    // [myRootRef setValue:@"Do you have data? You'll love Firebase. 123456"];
    
    
    /*
    // Read data and react to changes
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
    }];
    */
    NSDictionary *alanisawesome = @{
                                    @"full_name" : @"Alan Turing",
                                    @"date_of_birth": @"June 23, 1912"
                                    };
    NSDictionary *gracehop = @{
                               @"full_name" : @"Grace Hopper",
                               @"date_of_birth": @"December 9, 1906"
                               };
    Firebase* usersRef = [ref childByAppendingPath: @"users"];
    NSDictionary *users = @{
                            @"alanisawesome": alanisawesome,
                            @"gracehop": gracehop
                            };
    [usersRef setValue: users];
    
    
    Firebase* alanRef = [usersRef childByAppendingPath: @"alanisawesome"];
    [alanRef setValue: alanisawesome];
    
    Firebase* hopperRef = [usersRef childByAppendingPath: @"gracehop"];
    [hopperRef setValue: gracehop];
    
    
    
    // Get a reference to our posts
    Firebase* postsRef = [[Firebase alloc] initWithUrl: @"https://quickstart.firebaseio.com/users/gracehop/"];
    
    // Attach a block to read the data at our posts reference
    [postsRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        NSDictionary *readData = snapshot.value;
        
        NSLog(@"%@", [readData objectForKey:@"full_name"]);
        
        
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
