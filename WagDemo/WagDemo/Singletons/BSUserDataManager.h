//
//  BSUserDataManager.h
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import Foundation;

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BSUserDataManager : NSObject

// Public Properties

// Public Methods
+ (nonnull instancetype)sharedManager;

- (void)downloadAndProcessUsers;
- (void)deleteAllUsers;

@end
