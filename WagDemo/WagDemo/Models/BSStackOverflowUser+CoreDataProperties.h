//
//  BSStackOverflowUser+CoreDataProperties.h
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//
//

#import "BSStackOverflowUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BSStackOverflowUser (CoreDataProperties)

+ (NSFetchRequest<BSStackOverflowUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *displayName;
@property (nullable, nonatomic, copy) NSNumber *reputation;
@property (nullable, nonatomic, copy) NSNumber *badgeBronze;
@property (nullable, nonatomic, copy) NSNumber *badgeSilver;
@property (nullable, nonatomic, copy) NSNumber *badgeGold;
@property (nullable, nonatomic, copy) NSNumber *accountID;
@property (nullable, nonatomic, retain) BSImageInfo *imageInfo;

@end

NS_ASSUME_NONNULL_END
