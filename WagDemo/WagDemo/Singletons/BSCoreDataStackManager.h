//
//  BSCoreDataStackManager.h
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import Foundation;
@import CoreData;

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BSCoreDataStackManager : NSObject

// Public Properties
@property (readonly, strong) NSPersistentContainer *persistentContainer;

// Public Methods
+ (nonnull instancetype)sharedManager;

- (void)saveContext;

@end
