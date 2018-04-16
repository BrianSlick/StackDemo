//
//  BSImageDataManager.h
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import Foundation;
@import UIKit;
@import CoreData;

// Forward Declarations and Classes
@class BSImageInfo;

// Public Constants

// Protocols

@interface BSImageDataManager : NSObject

// Public Properties

// Public Methods
+ (nonnull instancetype)sharedManager;

+ (nullable BSImageInfo *)newImageInfoForRemoteURLString:(nonnull NSString *)urlString
                                               inContext:(nonnull NSManagedObjectContext *)context;
+ (nullable NSURL *)fileURLForImageFileName:(nullable NSString *)fileName;

- (BOOL)isDownloadingImageForImageInfo:(nonnull BSImageInfo *)imageInfo;
- (BOOL)isLocalImageAvailableForImageInfo:(nonnull BSImageInfo *)imageInfo;

+ (nonnull UIImage *)imageForImageInfo:(nonnull BSImageInfo *)imageInfo;

- (void)downloadImageForImageInfo:(nonnull BSImageInfo *)imageInfo;

@end
