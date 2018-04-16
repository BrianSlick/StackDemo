//
//  BSStackOverflowUser+BSAdditions.h
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSStackOverflowUser+CoreDataClass.h"
#import "BSStackOverflowUser+CoreDataProperties.h"

@interface BSStackOverflowUser (BSAdditions)

- (void)populateWithJSONUser:(nullable NSDictionary *)jsonUser;

@end
