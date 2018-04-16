//
//  BSImageDataManager.m
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSImageDataManager.h"

// Other Global

// Managers
#import "BSNetworkManager.h"

// Helpers

// Categories

// Models
#import "BSImageInfo+CoreDataClass.h"

@interface BSImageDataManager ()

// Private Properties
@property (nonatomic, strong) NSMutableSet *downloadsInProgress;

@end

@implementation BSImageDataManager

#pragma mark - Custom Getters and Setters

- (NSMutableSet *)downloadsInProgress
{
    if (_downloadsInProgress == nil)
    {
        _downloadsInProgress = [[NSMutableSet alloc] init];
    }
    return _downloadsInProgress;
}

#pragma mark - Public Methods

+ (nullable BSImageInfo *)newImageInfoForRemoteURLString:(nonnull NSString *)urlString
                                               inContext:(nonnull NSManagedObjectContext *)context;
{
    if ( ([urlString length] == 0) || (context == nil) )
    {
        return nil;
    }
    
    // First we will find out if we already know about this url.
    
    NSFetchRequest *fetchRequest = [BSImageInfo fetchRequest];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"urlString == %@", urlString]];

    NSArray *imageInfos = [context executeFetchRequest:fetchRequest error:nil];
    BSImageInfo *imageInfo = [imageInfos firstObject];
    
    if (imageInfo != nil)
    {
        // We do, so just use the existing object
        return imageInfo;
    }
    
    // We don't, so create a new one.
    
    NSString *fileName = [[NSUUID UUID] UUIDString];
    NSString *fileExtension = [BSImageDataManager bestGuessFileExtensionForURLString:urlString];
    NSString *fullFileName = [fileName stringByAppendingPathExtension:fileExtension];
    
    imageInfo = [[BSImageInfo alloc] initWithContext:context];
    [imageInfo setUrlString:urlString];
    [imageInfo setLocalFileName:fullFileName];
    
    return imageInfo;
}

+ (nullable NSURL *)fileURLForImageFileName:(nullable NSString *)fileName
{
    if ([fileName length] == 0)
    {
        return nil;
    }
    
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
                                                           inDomains:NSUserDomainMask];

    NSURL *url = [urls firstObject];
    url = [url URLByAppendingPathComponent:fileName];
    
    return url;
}

- (BOOL)isDownloadingImageForImageInfo:(nonnull BSImageInfo *)imageInfo
{
    NSString *urlString = [imageInfo urlString];

    return [[self downloadsInProgress] containsObject:urlString];
}

- (BOOL)isLocalImageAvailableForImageInfo:(nonnull BSImageInfo *)imageInfo
{
    NSURL *fileURL = [BSImageDataManager fileURLForImageFileName:[imageInfo localFileName]];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]];
}

+ (nonnull UIImage *)imageForImageInfo:(nonnull BSImageInfo *)imageInfo
{
    UIImage *image = nil;
    
    if ([[BSImageDataManager sharedManager] isLocalImageAvailableForImageInfo:imageInfo])
    {
        NSURL *fileURL = [BSImageDataManager fileURLForImageFileName:[imageInfo localFileName]];
        
        image = [UIImage imageWithContentsOfFile:[fileURL path]];
    }
    
    if (image == nil)
    {
        image = [UIImage imageNamed:@"placeholder"];
        
    }
    
    return image;
}

- (void)downloadImageForImageInfo:(nonnull BSImageInfo *)imageInfo
{
    NSURL *remoteURL = [NSURL URLWithString:[imageInfo urlString]];
    NSURL *fileURL = [BSImageDataManager fileURLForImageFileName:[imageInfo localFileName]];
    
    if ( (remoteURL == nil) || (fileURL == nil) )
    {
        return;
    }
    
    [self changeDownloadStatusForImageInfo:imageInfo isDownloading:YES];
    
    [[BSNetworkManager sharedManager] downloadImageFromURL:remoteURL
                                                 toFileURL:fileURL
                                                   success:^{
                                                       
                                                       [self changeDownloadStatusForImageInfo:imageInfo isDownloading:NO];

                                                       
                                                   }
                                                   failure:^(NSString *errorMessage) {
                                                       
                                                       [self changeDownloadStatusForImageInfo:imageInfo isDownloading:NO];

                                                   }];
}

#pragma mark - Private Methods

+ (nonnull NSString *)bestGuessFileExtensionForURLString:(nonnull NSString *)urlString
{
    // Sample URLs observed in raw data:
    // https://www.gravatar.com/avatar/89927e2f4bde24991649b353a37678b9?s=128&d=identicon&r=PG
    // https://i.stack.imgur.com/Cii6b.png?s=128&g=1
    // So 1) The URL might not include a file extension, and 2) even if it is there, it might not be last.
    // We will scan for known image file extensions anywhere in the URL. If nothing turns up, we'll just use a default value.
    
    // Including the dot here to reduce the chance of the string just happening to appear somewhere in the file name.
    NSArray *knownFileTypes = @[ @".jpg", @".jpeg", @".gif", @".png" ];
    
    NSString *extensionToReturn = nil;
    
    for (NSString *extension in knownFileTypes)
    {
        NSRange range = [urlString rangeOfString:extension];
        if (range.location != NSNotFound)
        {
            extensionToReturn = extension;
            break;
        }
    }
    
    if (extensionToReturn == nil)
    {
        extensionToReturn = [knownFileTypes firstObject];   // Just for sake of simplicity.
    }
    
    // But we don't actually care about the dot, so remove it before proceeding.
    extensionToReturn = [extensionToReturn stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    return extensionToReturn;
}

- (void)changeDownloadStatusForImageInfo:(BSImageInfo *)imageInfo
                           isDownloading:(BOOL)isDownloading
{
    NSString *urlString = [imageInfo urlString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (isDownloading)
        {
            [[self downloadsInProgress] addObject:urlString];
        }
        else
        {
            [[self downloadsInProgress] removeObject:urlString];
        }
        
        NSDictionary *userInfo = @{ BSPayloadKeyImageURLString : urlString };
        
        NSNotification *notification = [[NSNotification alloc] initWithName:BSNotificationImageDownloadStatusDidChange
                                                                     object:nil
                                                                   userInfo:userInfo];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    });
}

#pragma mark - Singleton

+ (nonnull instancetype)sharedManager
{
    static dispatch_once_t predicate;
    static BSImageDataManager *shared = nil;
    
    dispatch_once(&predicate, ^{
        
        shared = [[[self class] alloc] init];
        
    });
    
    return shared;
}

@end
