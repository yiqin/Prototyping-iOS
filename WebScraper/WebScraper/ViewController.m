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
#import "YQLabel.h"

@class YQLabelWithFixedWidth;

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *kimonoResults;
@property (strong, nonatomic) NSArray *kimonoResultsHeader;
@property (strong, nonatomic) NSArray *kimonoResultsBody;

@property (strong, nonatomic) YQLabelWithFixedWidth *articleTitle;
@property (strong, nonatomic) YQLabelWithFixedWidth *articleAuthor;
@property (strong, nonatomic) YQLabelWithFixedWidth *publishDate;

@property (strong, nonatomic) YQLabelWithFixedWidth *currentBodyLabel;
@property (strong, nonatomic) YQLabelWithFixedWidth *lastBodyLabel;

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
     UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    // Only one page and one link
    NSURL *url = [NSURL URLWithString:@"https://www.kimonolabs.com/api/drvp3au6?apikey=8541e9ff8ff5291b4d84b9f75550c9b8"];
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
    self.kimonoResultsHeader = [self.kimonoResults objectForKey:@"Header"];
    self.kimonoResultsBody = [self.kimonoResults objectForKey:@"Body"];
    
    [self displayHeader];
    
    self.lastBodyLabel = self.publishDate;
    [self displayBody];
}

- (void)displayHeader
{
    float tempOriginY = 72.0;
    CGRect tempFrame = CGRectMake(20.0, tempOriginY, CGRectGetWidth(self.view.frame)-40.0, 1024.0);
    NSDictionary *tempHead = [self.kimonoResultsHeader objectAtIndex:0];
    
    NSString *tempTitle = [tempHead objectForKey:@"Title"];
    self.articleTitle = [[YQLabelWithFixedWidth alloc] initWithFrame:tempFrame
                                                                font:[UIFont fontWithName:@"Georgia" size:20]
                                                                text:tempTitle
                                                       textAlignment:NSTextAlignmentLeft];
    
    
    NSString *tempAuthor = [[tempHead objectForKey:@"Author"] objectForKey:@"text"];
    self.articleAuthor = [[YQLabelWithFixedWidth alloc] initWithText:tempAuthor
                                                       textAlignment:NSTextAlignmentLeft
                                                            fontSize:17
                                                 labelEstimatedWidth:CGRectGetWidth(self.view.frame) afterUILabel:self.articleTitle];
    
    NSString *tempDate = [tempHead objectForKey:@"Date"];
    self.publishDate = [[YQLabelWithFixedWidth alloc] initWithText:tempDate
                                                     textAlignment:NSTextAlignmentLeft
                                                          fontSize:17
                                               labelEstimatedWidth:CGRectGetWidth(self.view.frame)
                                                      afterUILabel:self.articleAuthor];
    
    [self.view addSubview:self.articleTitle];
    [self.view addSubview:self.articleAuthor];
    [self.view addSubview:self.publishDate];
}

- (void)displayBody
{
    for (NSDictionary *tempBody in self.kimonoResultsBody) {
        NSDictionary *temp = [tempBody objectForKey:@"Article"];
        NSString *bodyText = [temp objectForKey:@"text"];
        
        if ([bodyText length] > 0) {
            self.currentBodyLabel = [[YQLabelWithFixedWidth alloc] initWithText:bodyText
                                                                  textAlignment:NSTextAlignmentLeft
                                                                       fontSize:18
                                                            labelEstimatedWidth:CGRectGetWidth(self.view.frame)-40
                                                                     afterFrame:self.lastBodyLabel.frame];
        }
        else {
            self.currentBodyLabel = [[YQLabelWithFixedWidth alloc] initWithText:@"This is empty"
                                                                  textAlignment:NSTextAlignmentLeft
                                                                       fontSize:25
                                                            labelEstimatedWidth:CGRectGetWidth(self.view.frame)-40
                                                                   afterUILabel:self.lastBodyLabel];
        }
        
        self.lastBodyLabel = self.currentBodyLabel;
        [self.view addSubview:self.currentBodyLabel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
