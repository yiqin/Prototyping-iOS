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

+(void)beginTaskWithCallbackBlock:(void (^)(void))callbackBlock
{
    NSLog(@"In the block");
    
    dispatch_async(queueTask, ^{
        NSLog(@"Dispatch Async");
        
        // A delay
        uint32_t x=arc4random();
        sleep((x % 4) + 2);
        
        callbackBlock();
    });
    
    NSLog(@"The end");
}

@end
