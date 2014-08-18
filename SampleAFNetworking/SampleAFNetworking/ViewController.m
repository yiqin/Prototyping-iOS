//
//  ViewController.m
//  SampleAFNetworking
//
//  Created by yiqin on 7/20/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    // Test Week Day
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponent = [calender components:(NSWeekOfYearCalendarUnit |           NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];
    NSLog(@"%@",dateComponent);
    
    
    
    
    
    
    
    
    // AFNetWorking
    // https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-2.0-Migration-Guide#afhttprequestoperation-example
    // AFHTTPRequestOperation  - GET Method
    // Other methods - "GET, POST, PUT, DELETE", use AFHTTPRequestOperationManager
    
    
    // Kimono
    // 1 - Blue Apron
    NSURL *url1 = [NSURL URLWithString:@"https://www.kimonolabs.com/kimonoapis/7uqn1y8g?apikey=8541e9ff8ff5291b4d84b9f75550c9b8"];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
    
    operation1.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"Retrieve an API: %@", responseObject);
        // NSLog(@"Blue Apron - JSON: %@", [responseObject objectForKey:@"results"]);
        
        
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
    
    
    AFHTTPRequestOperationManager *myOperationManager = [[AFHTTPRequestOperationManager alloc] init];
    myOperationManager.operationQueue.maxConcurrentOperationCount = 5;
    // It makes sense now.
    // Set maxConcurrentOperationCount to 1
    // operation2 is finished first
    // Set maxConcurrentOperationCount to 2
    // operation1 is finished first, since operation2 and operation1 are scheduled at the same time.
    
    // [myOperationManager.operationQueue addOperation:operation2];
    [myOperationManager.operationQueue addOperation:operation1];
    
    
    // Follow the order in the mutableOperations
    NSMutableArray *mutableOperations = [NSMutableArray array];
    
    [mutableOperations addObject:operation2];
    [mutableOperations addObject:operation1];
    
    
    
    // YO Demo
    NSString *path1 = @"http://api.justyo.co/yoall/";
    NSDictionary *parameters1 = @{@"api_token": @"20af1dd2-93af-869f-446c-0675f8694095"};
    
	AFHTTPRequestOperationManager *operationManager1 = [AFHTTPRequestOperationManager manager];
	operationManager1.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    /*
    [operationManager1 POST:path1 parameters:parameters1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"YOOOOOOO SUCCESS");
	
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"FAILED");
		
    }];
    */
    
    
    // Advanced Kimono
    
    // NSString *path2_1 = @"https://www.kimonolabs.com/api/2wwctra6?apikey=8541e9ff8ff5291b4d84b9f75550c9b8";
    
    
    // Make some mistakes here.
    NSString *path2_1 = @"https://www.kimonolabs.com/kimonoapis/2wwctra6";
    NSString *path2_2 = @"/update";
    
    NSMutableString *path2 = [[NSMutableString alloc]init];
    
    [path2 appendString:path2_1];
    [path2 appendString:path2_2];
    
    NSDictionary *parameters2 = @{@"apikey": @"8541e9ff8ff5291b4d84b9f75550c9b8",
                                  @"targeturl": @"http://challengepost.com/software/evershare"};
    
    
    
	AFHTTPRequestOperationManager *operationManager2 = [AFHTTPRequestOperationManager manager];
	operationManager2.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager2.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operationManager2 POST:path2 parameters:parameters2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS - JSON: %@", responseObject);
        
        // if success, try another url and get it.
        [self getKimono];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"FAILED: %@", error);
		
    }];
    
    
    
    
    NSLog(@"hello world");
}


- (void) getKimono
{
    NSString *path = @"https://www.kimonolabs.com/api/2wwctra6?apikey=8541e9ff8ff5291b4d84b9f75550c9b8";
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
	operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operationManager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS - JSON: %@", responseObject);
        
        // if success, try another url
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"FAILED: %@", error);
		
    }];

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
