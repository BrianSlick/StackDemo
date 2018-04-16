//
//  BSStackOverflowJSONHelper.h
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

@interface BSStackOverflowJSONHelper : NSObject

// Public Properties

// Public Methods

#pragma mark - /users methods

+ (nullable NSDictionary *)jsonDictionaryFromUsersResponseData:(nullable NSData *)data
                                                       failure:(void (^ _Nullable)(NSString * _Nullable errorMessage))failureBlock;

+ (nullable NSArray *)jsonUserListFromJSONResults:(nullable NSDictionary *)jsonDictionary;

+ (nullable NSNumber *)accountIDFromJSONUser:(nullable NSDictionary *)jsonUser;
+ (nullable NSString *)displayNameFromJSONUser:(nullable NSDictionary *)jsonUser;
+ (nullable NSNumber *)reputationFromJSONUser:(nullable NSDictionary *)jsonUser;
+ (nullable NSString *)profileImageURLStringFromJSONUser:(nullable NSDictionary *)jsonUser;
+ (nullable NSDictionary *)badgeCountsFromJSONUser:(nullable NSDictionary *)jsonUser;
+ (nullable NSNumber *)bronzeBadgeFromJSONUser:(nullable NSDictionary *)jsonUser;
+ (nullable NSNumber *)silverBadgeFromJSONUser:(nullable NSDictionary *)jsonUser;
+ (nullable NSNumber *)goldBadgeFromJSONUser:(nullable NSDictionary *)jsonUser;


@end
