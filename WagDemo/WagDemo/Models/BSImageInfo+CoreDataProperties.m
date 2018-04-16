//
//  BSImageInfo+CoreDataProperties.m
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//
//

#import "BSImageInfo+CoreDataProperties.h"

@implementation BSImageInfo (CoreDataProperties)

+ (NSFetchRequest<BSImageInfo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"BSImageInfo"];
}

@dynamic urlString;
@dynamic localFileName;
@dynamic stackOverflowUser;

@end
