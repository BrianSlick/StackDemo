//
//  NSDictionary+TypeSafety.h
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import Foundation;

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface NSDictionary (TypeSafety)

// Public Methods
- (nullable NSString *)bs_stringForKey:(nullable id<NSCopying>)key;
- (nullable NSNumber *)bs_numberForKey:(nullable id<NSCopying>)key;
- (nullable NSDictionary *)bs_dictionaryForKey:(nullable id<NSCopying>)key;
- (nullable NSArray *)bs_arrayForKey:(nullable id<NSCopying>)key;

@end
