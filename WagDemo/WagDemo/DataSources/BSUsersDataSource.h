//
//  BSUsersDataSource.h
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import Foundation;
@import UIKit;

// Forward Declarations and Classes
@class BSStackOverflowUser;

// Public Constants

// Protocols


@interface BSUsersDataSource : NSObject

// Public Properties
@property (nonatomic, strong, readonly) NSArray<BSStackOverflowUser *> *users;

// Public Methods
- (void)reload;

- (NSInteger)numberOfUsers;
- (BSStackOverflowUser *)userAtIndex:(NSInteger)index;

- (NSIndexPath *)indexPathOfUserInfoWithRemoteImageURLString:(NSString *)urlString;

@end
