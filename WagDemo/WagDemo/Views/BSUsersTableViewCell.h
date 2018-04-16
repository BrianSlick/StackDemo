//
//  BSUsersTableViewCell.h
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import UIKit;

// Forward Declarations and Classes
#import "BSTableViewCell.h"
@class BSStackOverflowUser;

// Public Constants

// Protocols

@interface BSUsersTableViewCell : BSTableViewCell

// Public Properties

// Public Methods
- (void)populateWithUser:(BSStackOverflowUser *)user;

@end
