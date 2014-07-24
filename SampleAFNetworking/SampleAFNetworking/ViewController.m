//
//  ViewController.m
//  SampleAFNetworking
//
//  Created by yiqin on 7/20/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperation.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Kimono
    // 1 - Blue Apron
    NSURL *url1 = [NSURL URLWithString:@"https://www.kimonolabs.com/api/7uqn1y8g?apikey=8541e9ff8ff5291b4d84b9f75550c9b8"];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Blue Apron - JSON: %@", [responseObject objectForKey:@"results"]);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
    }];
    
    
    // 2 - Product Hunt
    NSURL *url2 = [NSURL URLWithString:@"https://www.kimonolabs.com/api/afhn5y42?apikey=8541e9ff8ff5291b4d84b9f75550c9b8"];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    AFHTTPRequestOperation *operation2 = [[AFHTTPRequestOperation alloc] initWithRequest:request2];
    
    operation2.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation2 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Product Hunt - JSON: %@", [responseObject objectForKey:@"results"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
    }];
    
    
    // Follow the order in the mutableOperations
    NSMutableArray *mutableOperations = [NSMutableArray array];
    [mutableOperations addObject:operation2];
    [mutableOperations addObject:operation1];
    
    // Something wrong here.
    /*
    NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        
        NSLog(@"%lu of %lu complete", (unsigned long)numberOfFinishedOperations, (unsigned long)totalNumberOfOperations);
        
    } completionBlock:^(NSArray *operations) {
        NSLog(@"All operations in batch complete");
    }];
    */
    
    // [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
    
    /*
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    [myQueue addOperations:operations waitUntilFinished:NO];
    [myQueue addOperationWithBlock:^{
        
        // Background work
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // Main thread work (UI usually)
        }];
    }];
    */
    
    // It seems good now.
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    // operation 2 takes a longer time.
    [myQueue addOperation:operation2];
    [myQueue addOperation:operation1];
    
    
    NSLog(@"hello world");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
