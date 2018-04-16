//
//  BSStackOverflowAPIVendor.m
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSStackOverflowAPIVendor.h"

// Libraries

// Other Global

// Categories

// Private Constants
NSString *const _Nonnull BSStackOverflowAPIBaseURLString = @"https://api.stackexchange.com/2.2/";

NSString *const _Nonnull BSStackOverflowAPIEndpointUsers = @"users";
// Add endpoints here...

NSString *const _Nonnull BSStackOverflowAPIParameterSite = @"site=stackoverflow";
// Add parameters here...

@implementation BSStackOverflowAPIVendor

+ (nonnull NSURL *)usersURL
{
    // Documentation: https://api.stackexchange.com/docs/users
    // Example URL: https://api.stackexchange.com/2.2/users?site=stackoverflow
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", BSStackOverflowAPIBaseURLString, BSStackOverflowAPIEndpointUsers, BSStackOverflowAPIParameterSite];

    return [NSURL URLWithString:urlString];
}

@end
