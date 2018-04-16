//
//  BSStackOverflowUser+BSAdditions.m
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSStackOverflowUser+BSAdditions.h"

// Managers
#import "BSImageDataManager.h"

// Helpers
#import "BSStackOverflowJSONHelper.h"

// Models
#import "BSImageInfo+CoreDataClass.h"

@implementation BSStackOverflowUser (BSAdditions)

- (void)populateWithJSONUser:(nullable NSDictionary *)jsonUser
{
    NSNumber *accountID = [BSStackOverflowJSONHelper accountIDFromJSONUser:jsonUser];
    NSString *displayName = [BSStackOverflowJSONHelper displayNameFromJSONUser:jsonUser];
    NSNumber *reputation = [BSStackOverflowJSONHelper reputationFromJSONUser:jsonUser];
    NSString *profileImageURLString = [BSStackOverflowJSONHelper profileImageURLStringFromJSONUser:jsonUser];
    NSNumber *bronzeBadge = [BSStackOverflowJSONHelper bronzeBadgeFromJSONUser:jsonUser];
    NSNumber *silverBadge = [BSStackOverflowJSONHelper silverBadgeFromJSONUser:jsonUser];
    NSNumber *goldBadge = [BSStackOverflowJSONHelper goldBadgeFromJSONUser:jsonUser];
    
    [self setAccountID:accountID];
    [self setDisplayName:displayName];
    [self setReputation:reputation];
    [self setBadgeBronze:bronzeBadge];
    [self setBadgeSilver:silverBadge];
    [self setBadgeGold:goldBadge];
    
    BSImageInfo *imageInfo = [BSImageDataManager newImageInfoForRemoteURLString:profileImageURLString
                                                                      inContext:[self managedObjectContext]];
    [self setImageInfo:imageInfo];
}

@end
