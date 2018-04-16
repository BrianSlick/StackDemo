//
//  BSUsersDataSource.m
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSUsersDataSource.h"

// Libraries
@import CoreData;

// Managers
#import "BSCoreDataStackManager.h"

// Models
#import "BSStackOverflowUser+CoreDataClass.h"
#import "BSImageInfo+CoreDataClass.h"

@interface BSUsersDataSource ()

// Private Properties
@property (nonatomic, strong) NSArray<BSStackOverflowUser *> *users;

@end

@implementation BSUsersDataSource

#pragma mark - Public Methods

- (void)reload
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"reputation" ascending:NO];
    
    NSManagedObjectContext *context = [[[BSCoreDataStackManager sharedManager] persistentContainer] viewContext];
    NSFetchRequest *fetchRequest = [BSStackOverflowUser fetchRequest];
    
    [fetchRequest setSortDescriptors:@[ sortDescriptor ]];
    
    NSArray *users = [context executeFetchRequest:fetchRequest error:nil];

    [self setUsers:users];
}

- (NSInteger)numberOfUsers
{
    return [[self users] count];
}

- (BSStackOverflowUser *)userAtIndex:(NSInteger)index
{
    return [[self users] objectAtIndex:index];
}

- (NSIndexPath *)indexPathOfUserInfoWithRemoteImageURLString:(NSString *)urlString
{
    NSInteger row = 0;
    
    for (BSStackOverflowUser *user in [self users])
    {
        BSImageInfo *imageInfo = [user imageInfo];
        
        if ([[imageInfo urlString] isEqualToString:urlString])
        {
            break;
        }
        
        row++;
    }
    
    return [NSIndexPath indexPathForRow:row inSection:0];
}

@end
