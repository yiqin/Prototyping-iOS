//
//  ViewController.m
//  WorkingWithBlock
//
//  Created by yiqin on 8/16/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ViewController.h"
#import "Task.h"

@interface ViewController ()

@property (strong, nonatomic) Task *task;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.task = [[Task alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickedButton:(id)sender
{
    [self.task beginTaskWithCallbackBlock:^{
        
        NSLog(@"The block works.");
        
        
    }];
    
    NSLog(@"The end");
}


@end
