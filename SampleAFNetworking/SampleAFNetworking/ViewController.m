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
    NSURL *url = [NSURL URLWithString:@"https://www.kimonolabs.com/api/7uqn1y8g?apikey=8541e9ff8ff5291b4d84b9f75550c9b8"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", [responseObject objectForKey:@"results"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
    }];
    
    
    [operation start];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
