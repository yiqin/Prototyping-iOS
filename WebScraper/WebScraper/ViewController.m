//
//  ViewController.m
//  WebScraper
//
//  Created by yiqin on 7/30/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *kimonoResults;
@property (strong, nonatomic) NSDictionary *kimonoResultsHeader;
@property (strong, nonatomic) NSDictionary *kimonoResultsBody;

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *author;
@property (strong, nonatomic) UILabel *date;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadDataFromKimono];
}

- (void)loadDataFromKimono
{
    // Only one page and one link
    NSURL *url = [NSURL URLWithString:@"https://www.kimonolabs.com/api/drvp3au6?apikey=8541e9ff8ff5291b4d84b9f75550c9b8"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.kimonoResults = [responseObject objectForKey:@"results"];
        [self displayDataFromKimono];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    }];
    
    AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc] init];
    operationManager.operationQueue.maxConcurrentOperationCount = 5;
    [operationManager.operationQueue addOperation:operation];
}

- (void)displayDataFromKimono
{
    self.kimonoResultsHeader = [self.kimonoResults objectForKey:@"Header"];
    self.kimonoResultsBody = [self.kimonoResults objectForKey:@"Body"];
    
    [self displayHeader];
    [self displayBody];
}

- (void)displayHeader
{
    
}

- (void)displayBody
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
