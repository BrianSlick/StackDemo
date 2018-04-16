//
//  BSUserDataManager.m
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSUserDataManager.h"

// Other Global
#import "Constants.h"

// Managers
#import "BSNetworkManager.h"
#import "BSCoreDataStackManager.h"

// Helpers
#import "BSStackOverflowJSONHelper.h"

// Categories
#import "BSStackOverflowUser+BSAdditions.h"

// Models
#import "BSStackOverflowUser+CoreDataClass.h"

@implementation BSUserDataManager

#pragma mark - Public Methods

- (void)downloadAndProcessUsers
{
    BSNetworkManager *networkManager = [BSNetworkManager sharedManager];
    
    [networkManager downloadUsersSuccess:^(NSData *data) {
        
        [self processUsersResponseData:data];
        
    }
                                 failure:^(NSString *errorMessage) {
                                     
                                     // TODO: Handle errors
                                     
                                 }];
}

- (void)deleteAllUsers
{
    BSCoreDataStackManager *coreDataManager = [BSCoreDataStackManager sharedManager];
    
    NSManagedObjectContext *context = [[coreDataManager persistentContainer] viewContext];
    
    NSFetchRequest *fetchRequest = [BSStackOverflowUser fetchRequest];
    
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
    
    [context executeRequest:deleteRequest error:nil];
    
    [coreDataManager saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BSNotificationUserListDidChange object:nil];
}

#pragma mark - Private Methods

- (void)processUsersResponseData:(NSData *)data
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSDictionary *jsonDictionary = [BSStackOverflowJSONHelper jsonDictionaryFromUsersResponseData:data
                                                                                              failure:^(NSString * _Nullable errorMessage) {
                                                                                                 
                                                                                                  // TODO: Handle errors
                                                                                                  
                                                                                              }];
        
        if (jsonDictionary == nil)
        {
            // TODO: Handle errors

            return;
        }
        
        NSArray *jsonUsers = [BSStackOverflowJSONHelper jsonUserListFromJSONResults:jsonDictionary];
        
        if (jsonUsers == nil)
        {
            // TODO: Handle errors
            
            return;
        }

        NSManagedObjectContext *context = [[[BSCoreDataStackManager sharedManager] persistentContainer] newBackgroundContext];
        NSFetchRequest *fetchRequest = [BSStackOverflowUser fetchRequest];
        
        for (NSDictionary *jsonUser in jsonUsers)
        {
            // We're going to look for an existing user in the database. If found, we'll update that
            // user with new information. If not found, we'll create a new user. The accountID will be
            // the basis for the search.
            
            NSNumber *accountID = [BSStackOverflowJSONHelper accountIDFromJSONUser:jsonUser];
            
            if (accountID == nil)
            {
                // Not really sure if this would ever happen. Not going to add the user for now.
                continue;
            }
            
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"accountID == %@", accountID]];
            
            NSArray *users = [context executeFetchRequest:fetchRequest error:nil];
            
            BSStackOverflowUser *user = [users firstObject];
            if (user == nil)
            {
                user = [[BSStackOverflowUser alloc] initWithContext:context];
            }
            
            [user populateWithJSONUser:jsonUser];
        }
        
        [context save:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            [[BSCoreDataStackManager sharedManager] saveContext];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:BSNotificationUserListDidChange object:nil];
            
        });
        
    });
}

#pragma mark - Singleton

+ (nonnull instancetype)sharedManager
{
    static dispatch_once_t predicate;
    static BSUserDataManager *shared = nil;
    
    dispatch_once(&predicate, ^{
        
        shared = [[[self class] alloc] init];
        
    });
    
    return shared;
}

@end
