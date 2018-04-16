//
//  BSStackOverflowUser+CoreDataProperties.m
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//
//

#import "BSStackOverflowUser+CoreDataProperties.h"

@implementation BSStackOverflowUser (CoreDataProperties)

+ (NSFetchRequest<BSStackOverflowUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"BSStackOverflowUser"];
}

@dynamic displayName;
@dynamic reputation;
@dynamic badgeBronze;
@dynamic badgeSilver;
@dynamic badgeGold;
@dynamic accountID;
@dynamic imageInfo;

@end
