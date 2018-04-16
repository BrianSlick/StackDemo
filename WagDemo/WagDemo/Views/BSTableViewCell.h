//
//  BSTableViewCell.h
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import UIKit;

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BSTableViewCell : UITableViewCell

// Public Properties

// Public Methods
+ (nonnull NSString *)bs_reuseIdentifier;

+ (void)registerNibForTableView:(nullable UITableView *)tableView;

+ (nullable instancetype)dequeueCellFromTableView:(nullable UITableView *)tableView;


@end
