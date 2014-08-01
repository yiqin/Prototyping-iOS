//
//  IchibanViewController.m
//  WebScraper
//
//  Created by yiqin on 7/31/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "IchibanViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import <Parse/Parse.h>
#import "NSDictionary+DictionaryToJSONString.h"

@interface IchibanViewController ()

@property (strong, nonatomic) NSDictionary *kimonoResults;
@property (strong, nonatomic) NSArray *kimonoResultsCollection1;
// @property (strong, nonatomic) NSArray *kimonoResultsBody;

@property (strong, nonatomic) NSMutableDictionary *categoriesDictionary;

@end

@implementation IchibanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.categoriesDictionary = [[NSMutableDictionary alloc] init];
    
    // [self loadDataFromKimono];
    [self directlyJSON];
}

- (void)loadDataFromKimono
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    // Only one page and one link
    NSURL *url = [NSURL URLWithString:@"https://www.kimonolabs.com/api/c5bve1lk?apikey=8541e9ff8ff5291b4d84b9f75550c9b8"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.kimonoResults = [responseObject objectForKey:@"results"];
        
        
        [self displayDataFromKimono];
        [spinner stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc] init];
    operationManager.operationQueue.maxConcurrentOperationCount = 5;
    [operationManager.operationQueue addOperation:operation];
}


- (void)displayDataFromKimono
{
    self.kimonoResultsCollection1 = [self.kimonoResults objectForKey:@"collection1"];
    
    for (NSDictionary *tempBody in self.kimonoResultsCollection1) {
        NSDictionary *temp = [tempBody objectForKey:@"property1"];
        NSString *bodyText = [temp objectForKey:@"text"];
        
        PFObject *newCategory = [PFObject objectWithClassName:@"ichibanCategoryIN"];
        newCategory[@"category"] = [bodyText lowercaseString];
        
        [newCategory saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"SUCCESS");
            }
        }];
    }
    
}


-(void)directlyJSON
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dish" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSDictionary *temp1 = json;
    
    
    self.kimonoResultsCollection1 = [temp1 objectForKey:@"collection1"];
    
    for (NSDictionary *tempBody in self.kimonoResultsCollection1) {
        NSDictionary *property1 = [tempBody objectForKey:@"property1"];
        NSString *property2 = [tempBody objectForKey:@"property2"];
        NSString *property3 = [tempBody objectForKey:@"property3"];
        
        NSString *name = [property1 objectForKey:@"text"];
        NSString *category = property2;
        NSString *price = [property3 substringFromIndex:1];
        
        PFObject *newDish = [PFObject objectWithClassName:@"DishesIN"];
        
        newDish[@"category"] = category;
        
        
        if (![self.categoriesDictionary objectForKey:category]) {
            [self.categoriesDictionary setValue:@1 forKey:category];
        }
        
        
        
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumberPrice = [f numberFromString:price];
        NSArray *dishArrayKeys = [NSArray arrayWithObjects:@"nameChinese", @"name", @"price", nil];
        NSArray *dishArrayObjects = [NSArray arrayWithObjects:@"", name, myNumberPrice, nil];
        
        NSDictionary *dishDictionaryInput = [NSDictionary dictionaryWithObjects:dishArrayObjects forKeys:dishArrayKeys];
        NSString *dishDictionaryInputString = [dishDictionaryInput DictionaryToJSONString];
        
        newDish[@"dish"] = dishDictionaryInputString;
        newDish[@"orderCount"] = @0;
        
        [newDish saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {

            }
        }];
        

    }
}
- (IBAction)finishedCategories:(id)sender {
    
    for (id key in self.categoriesDictionary) {
        
        PFObject *newCategory = [PFObject objectWithClassName:@"ichibanCategoryIN"];
        newCategory[@"category"] = key;
        
        [newCategory saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"SUCCESS");
            }
        }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
