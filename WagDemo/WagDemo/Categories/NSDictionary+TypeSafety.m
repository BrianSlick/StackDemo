//
//  NSDictionary+TypeSafety.m
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "NSDictionary+TypeSafety.h"

@implementation NSDictionary (TypeSafety)

- (nullable NSString *)bs_stringForKey:(nullable id<NSCopying>)key
{
    if (key == nil)
    {
        return nil;
    }
    
    id object = [self objectForKey:key];
    
    return [object isKindOfClass:[NSString class]] ? object : nil;
}

- (nullable NSNumber *)bs_numberForKey:(nullable id<NSCopying>)key
{
    if (key == nil)
    {
        return nil;
    }
    
    id object = [self objectForKey:key];
    
    return [object isKindOfClass:[NSNumber class]] ? object : nil;
}

- (nullable NSDictionary *)bs_dictionaryForKey:(nullable id<NSCopying>)key
{
    if (key == nil)
    {
        return nil;
    }
    
    id object = [self objectForKey:key];
    
    return [object isKindOfClass:[NSDictionary class]] ? object : nil;
}

- (nullable NSArray *)bs_arrayForKey:(nullable id<NSCopying>)key
{
    if (key == nil)
    {
        return nil;
    }
    
    id object = [self objectForKey:key];
    
    return [object isKindOfClass:[NSArray class]] ? object : nil;
}

@end
