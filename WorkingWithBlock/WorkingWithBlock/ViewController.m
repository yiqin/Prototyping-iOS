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

// dispatch_queue_t queue;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.task = [[Task alloc] init];
    
    // queue = dispatch_queue_create("com.adamburkepile.queue",nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedButton:(id)sender
{
    /*
    dispatch_async(queue, ^{
        [self.task beginTaskWithCallbackBlock:^{
            NSLog(@"The block works.");
        }];
    });
    */
    
    NSLog(@"Tap the button");
    
    // Class method now
    [Task beginTaskWithCallbackBlock:^{
        NSLog(@"The block finished");
    }];
    
    NSLog(@"The end");
    
}

- (IBAction)clickedAddButton:(id)sender
{
    int (^add)(int,int) = ^(int number1, int number2){
        return number1+number2;
    };
    
    
    int resultFromBlock = add(2,2);
    
    NSLog(@"%i", resultFromBlock);
    
    
    
}


@end
