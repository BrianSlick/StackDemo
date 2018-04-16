//
//  BSNetworkManager.h
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import Foundation;

// Forward Declarations and Classes
#import "Constants.h"

// Public Constants

// Protocols

@interface BSNetworkManager : NSObject

// Public Properties
@property (nonnull, nonatomic, strong) NSURLSession *session;

@property (nonatomic, assign) BSNetworkOperationStatus usersNetworkOperationStatus;

// Public Methods
+ (nonnull instancetype)sharedManager;

#pragma mark - /users Methods
- (void)downloadUsersSuccess:(void (^)(NSData *data))successBlock
                     failure:(void (^)(NSString *errorMessage))failureBlock;

#pragma mark - Image Methods

- (void)downloadImageFromURL:(NSURL *)remoteURL
                   toFileURL:(NSURL *)fileURL
                     success:(void (^)(void))successBlock
                     failure:(void (^)(NSString *errorMessage))failureBlock;

@end
