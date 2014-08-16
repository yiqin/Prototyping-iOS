//
//  Task.m
//  WorkingWithBlock
//
//  Created by yiqin on 8/16/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "Task.h"

@implementation Task




-(void)beginTaskWithCallbackBlock:(void (^)(void))callbackBlock
{
    NSLog(@"In the block");

    uint32_t x=arc4random();
    sleep((x % 4) + 2);
    
    callbackBlock();
}

@end
