//
//  BSNetworkManager.m
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSNetworkManager.h"

// Other Global
#import "BSStackOverflowAPIVendor.h"
#import "Constants.h"

@implementation BSNetworkManager

#pragma mark - Custom Getters and Setters

- (nonnull NSURLSession *)session
{
    if (_session == nil)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (void)setUsersNetworkOperationStatus:(BSNetworkOperationStatus)usersNetworkOperationStatus
{
    _usersNetworkOperationStatus = usersNetworkOperationStatus;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BSNotificationUsersDownloadStatusDidChange object:nil];
}

#pragma mark - /users Methods

- (void)downloadUsersSuccess:(void (^)(NSData *data))successBlock
                     failure:(void (^)(NSString *errorMessage))failureBlock;
{
    [self setUsersNetworkOperationStatus:BSNetworkOperationStatusDownloading];
    
    NSURL *url = [BSStackOverflowAPIVendor usersURL];
    
    NSURLSessionDataTask *task = [[self session] dataTaskWithURL:url
                                               completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                   
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       
                                                       [self setUsersNetworkOperationStatus:BSNetworkOperationStatusNoActivity];

                                                       if (error != nil)
                                                       {
                                                           if (failureBlock != nil)
                                                           {
                                                               failureBlock([error localizedDescription]);
                                                           }
                                                           
                                                           return;
                                                       }
                                                       
                                                       if (successBlock != nil)
                                                       {
                                                           successBlock(data);
                                                       }
                                                       
                                                   });

                                               }];
    
    [task resume];
}

#pragma mark - Image Methods

- (void)downloadImageFromURL:(NSURL *)remoteURL
                   toFileURL:(NSURL *)fileURL
                     success:(void (^)(void))successBlock
                     failure:(void (^)(NSString *errorMessage))failureBlock
{
    void (^validFailureBlock)(NSString *message) = ^(NSString *message) {
        
        if (failureBlock != nil)
        {
            failureBlock(message);
        }
        
    };

    if (remoteURL == nil)
    {
        validFailureBlock(@"Remote URL Not Provided");
        return;
    }
    
    if (fileURL == nil)
    {
        validFailureBlock(@"Local File URL Not Provided");
        return;
    }
    
    NSURLSessionDownloadTask *task = [[self session] downloadTaskWithURL:remoteURL
                                                       completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                           
                                                           if (error != nil)
                                                           {
                                                               dispatch_async(dispatch_get_main_queue(), ^{

                                                                   validFailureBlock([error localizedDescription]);
                                                                   
                                                               });
                                                               
                                                               return;
                                                           }
                                                           
#warning Added delay for testing purposes. Comment out for normal performance.
//                                                           sleep(2);
                                                           
                                                           [[NSFileManager defaultManager] copyItemAtURL:location
                                                                                                   toURL:fileURL
                                                                                                   error:nil];
                                                           
                                                           if (successBlock != nil)
                                                           {
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   
                                                                   successBlock();

                                                               });
                                                           }
                                                           
                                                       }];
    
    [task resume];
}

#pragma mark - Singleton

+ (nonnull instancetype)sharedManager
{
    static dispatch_once_t predicate;
    static BSNetworkManager *shared = nil;
    
    dispatch_once(&predicate, ^{
        
        shared = [[[self class] alloc] init];
        
    });
    
    return shared;
}

@end
