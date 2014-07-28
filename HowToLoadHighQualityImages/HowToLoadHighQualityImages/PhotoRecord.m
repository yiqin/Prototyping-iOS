//
//  PhotoRecord.m
//  HowToLoadHighQualityImages
//
//  Created by yiqin on 7/26/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "PhotoRecord.h"

@implementation PhotoRecord

@synthesize name = something1;
@synthesize image = _image;
@synthesize URL = something2;
@synthesize hasImage = _hasImage;
@synthesize filtered = _filtered;
@synthesize failed = _failed;


- (BOOL)hasImage {
    return _image != nil;
}


- (BOOL)isFailed {
    return _failed;
}


- (BOOL)isFiltered {
    return _filtered;
}


@end
