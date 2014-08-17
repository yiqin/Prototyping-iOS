//
//  Task.h
//  WorkingWithBlock
//
//  Created by yiqin on 8/16/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

+ (void)beginTaskWithInput1:(NSString *)input1 input2:(NSString *)input2 callbackBlock:(void (^)(NSString *str, NSString *error))callbackBlock;

@end
