//
//  BSImageInfo+CoreDataProperties.h
//  WagDemo
//
//  Created by Brian Slick on 4/13/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//
//

#import "BSImageInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BSImageInfo (CoreDataProperties)

+ (NSFetchRequest<BSImageInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *urlString;
@property (nullable, nonatomic, copy) NSString *localFileName;
@property (nullable, nonatomic, retain) NSSet<BSStackOverflowUser *> *stackOverflowUser;

@end

@interface BSImageInfo (CoreDataGeneratedAccessors)

- (void)addStackOverflowUserObject:(BSStackOverflowUser *)value;
- (void)removeStackOverflowUserObject:(BSStackOverflowUser *)value;
- (void)addStackOverflowUser:(NSSet<BSStackOverflowUser *> *)values;
- (void)removeStackOverflowUser:(NSSet<BSStackOverflowUser *> *)values;

@end

NS_ASSUME_NONNULL_END
