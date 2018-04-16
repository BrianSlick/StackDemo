//
//  BSTableViewCell.m
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSTableViewCell.h"

// Libraries

// Other Global

// Categories

// Models

// Private Constants

@interface BSTableViewCell ()

// Private Properties

@end

@implementation BSTableViewCell

#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization and UI Creation Methods

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:[[self class] bs_reuseIdentifier]];
    if (self)
    {
        // Initialization code
    }

    return self;
}

#pragma mark - UITableViewCell Overrides

// From http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html
- (NSString *)reuseIdentifier
{
    return [[self class] bs_reuseIdentifier];
}

#pragma mark - Misc Methods

// From http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html
+ (nonnull NSString *)bs_reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void)registerNibForTableView:(nullable UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    
    UINib *cellNib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:className];
}

+ (nullable instancetype)dequeueCellFromTableView:(nullable UITableView *)tableView
{
    return [tableView dequeueReusableCellWithIdentifier:[[self class] bs_reuseIdentifier]];
}

@end
