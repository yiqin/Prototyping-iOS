//
//  Task.m
//  WorkingWithBlock
//
//  Created by yiqin on 8/16/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "Task.h"

@implementation Task

dispatch_queue_t queueTask;

-(id)init
{
    self = [super init];
    if (self) {
        queueTask = dispatch_queue_create("com.test",nil);
    }
    return self;
}

// blocks are a type of callback and could be considered a form of delegation limited to the method or function.
+ (void)beginTaskWithInput1:(NSString *)input1 input2:(NSString *)input2 callbackBlock:(void (^)(NSString *str, NSString *error))callbackBlock
{
    
    NSLog(@"Input1 %@", input1);
    NSLog(@"Input2 %@", input2);
    
    NSLog(@"In the block");
    
    dispatch_async(queueTask, ^{
        NSLog(@"First Dispatch Async");
        
        // A delay
        uint32_t x=arc4random();
        sleep((x % 4) + 2);
        
        NSLog(@"First Finish");
        
        callbackBlock(@"Hello world",@"Great");
    });

    
    dispatch_async(queueTask, ^{
        NSLog(@"Second Dispatch Async");
        
        // A delay
        uint32_t x=arc4random();
        sleep((x % 4) + 5);
        
        NSLog(@"Second Finish");
    });
    
    NSLog(@"The end");
}

@end
