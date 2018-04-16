//
//  BSStackOverflowJSONHelper.m
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSStackOverflowJSONHelper.h"

// Categories
#import "NSDictionary+TypeSafety.h"

@implementation BSStackOverflowJSONHelper

#pragma mark - /users methods

+ (nullable NSDictionary *)jsonDictionaryFromUsersResponseData:(nullable NSData *)data
                                                       failure:(void (^ _Nullable)(NSString * _Nullable errorMessage))failureBlock
{
    void (^validFailureBlock)(NSString *message) = ^(NSString *message) {
        
        if (failureBlock != nil)
        {
            failureBlock(message);
        }
        
    };
    
    if (data == nil)
    {
        validFailureBlock(@"No data provided");
        return nil;
    }
    
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&error];
    if (jsonDictionary == nil)
    {
        validFailureBlock([error localizedDescription]);
        return nil;
    }
    
    if ([jsonDictionary isKindOfClass:[NSArray class]])
    {
        validFailureBlock(@"Unexpected data structure from server");
        return nil;
    }
    
    {{
        // If there are known error messages that might be in the payload, search for them here.
        // This is offered as an example, and does not necessarily reflect a typical SO response.
        
        NSDictionary *errorDictionary = [jsonDictionary bs_dictionaryForKey:@"error"];
        if (errorDictionary != nil)
        {
            NSString *errorMessage = [errorDictionary bs_stringForKey:@"message"] ?: @"Unknown Server Error";
            
            validFailureBlock(errorMessage);
            return nil;
        }
    }}
    
    return jsonDictionary;
}

+ (nullable NSArray *)jsonUserListFromJSONResults:(nullable NSDictionary *)jsonDictionary
{
    NSArray *userList = [jsonDictionary bs_arrayForKey:@"items"];
    
    return userList;
}

// API Documentation
// https://api.stackexchange.com/docs/types/user

+ (nullable NSNumber *)accountIDFromJSONUser:(nullable NSDictionary *)jsonUser;
{
    return [jsonUser bs_numberForKey:@"account_id"];
}

+ (nullable NSString *)displayNameFromJSONUser:(nullable NSDictionary *)jsonUser
{
    return [jsonUser bs_stringForKey:@"display_name"];
}

+ (nullable NSNumber *)reputationFromJSONUser:(nullable NSDictionary *)jsonUser
{
    return [jsonUser bs_numberForKey:@"reputation"];
}

+ (nullable NSString *)profileImageURLStringFromJSONUser:(nullable NSDictionary *)jsonUser
{
    return [jsonUser bs_stringForKey:@"profile_image"];
}

// API Documentation
// https://api.stackexchange.com/docs/types/badge-count

+ (nullable NSDictionary *)badgeCountsFromJSONUser:(nullable NSDictionary *)jsonUser
{
    return [jsonUser bs_dictionaryForKey:@"badge_counts"];
}

+ (nullable NSNumber *)bronzeBadgeFromJSONUser:(nullable NSDictionary *)jsonUser
{
    NSDictionary *badgeCounts = [BSStackOverflowJSONHelper badgeCountsFromJSONUser:jsonUser];
    
    return [badgeCounts bs_numberForKey:@"bronze"];
}

+ (nullable NSNumber *)silverBadgeFromJSONUser:(nullable NSDictionary *)jsonUser
{
    NSDictionary *badgeCounts = [BSStackOverflowJSONHelper badgeCountsFromJSONUser:jsonUser];
    
    return [badgeCounts bs_numberForKey:@"silver"];
}

+ (nullable NSNumber *)goldBadgeFromJSONUser:(nullable NSDictionary *)jsonUser
{
    NSDictionary *badgeCounts = [BSStackOverflowJSONHelper badgeCountsFromJSONUser:jsonUser];
    
    return [badgeCounts bs_numberForKey:@"gold"];
}

@end
