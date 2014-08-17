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

// This part is confusing.
typedef int (^MathBlock)(int, int);

@property (strong) MathBlock mathBlock;
@property (strong, nonatomic) Task *task;

@end

@implementation ViewController

// dispatch_queue_t queue;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initBlock];
    self.task = [[Task alloc] init];
    
    // queue = dispatch_queue_create("com.adamburkepile.queue",nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBlock
{
    [self doMathWithBlock:^int(int a, int b) {
        return a + b;
    }];
    
    
}

- (void)doMathWithBlock:(MathBlock) mathBlock
{
    // Since a block is just an Objective-C object, you can store it in a property so you can call it later.
    self.mathBlock = mathBlock;
}

- (IBAction)clickedButton:(id)sender
{
    // Call block
    NSLog(@"Math Block: %i", self.mathBlock(1,2));
    
    
    /*
    dispatch_async(queue, ^{
        [self.task beginTaskWithCallbackBlock:^{
            NSLog(@"The block works.");
        }];
    });
    */
    
    NSLog(@"Tap the button");
    
    // Class method now
    [Task beginTaskWithInput1:@"aaaaaaaaaaaaaa" input2:@"bbbbbbbbbbbbbb" callbackBlock:^(NSString *str, NSString *error) {
        NSLog(@"The block is finished: %@ + %@", str, error);
    }];
    
    NSLog(@"Button is the end");
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
