//
//  ListTableViewController.h
//  HowToLoadHighQualityImages
//
//  Created by yiqin on 7/26/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

// 1: You can delete CoreImage from ListViewController header, since you donít need it anymore. However, you do need to import PhotoRecord.h, PendingOperations.h, ImageDownloader.h and ImageFiltration.h.
#import <UIKit/UIKit.h>
// #import <CoreImage/CoreImage.h> ... you don't need CoreImage here anymore.
#import "PhotoRecord.h"
#import "PendingOperations.h"
#import "ImageDownloader.h"
#import "ImageFiltration.h"
// 2: Hereís the reference to the AFNetworking library.
#import "AFNetworking/AFNetworking.h"

#define kDatasourceURLString @"https://sites.google.com/site/soheilsstudio/tutorials/nsoperationsampleproject/ClassicPhotosDictionary.plist"

// 3: Make sure to make ListViewController compliant to ImageDownloader and ImageFiltration delegate methods.
@interface ListTableViewController : UITableViewController <ImageDownloaderDelegate, ImageFiltrationDelegate>

// 4: You donít need the data source as-is. You are going to create instances of PhotoRecord using the property list. So, change the class of ìphotosî from NSDictionary to NSMutableArray, so that you can update the array of photos.
@property (nonatomic, strong) NSMutableArray *photos; // main data source of controller

// 5: This property is used to track pending operations.
@property (nonatomic, strong) PendingOperations *pendingOperations;
@end
