//
//  BSCoreDataStackManager.m
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSCoreDataStackManager.h"

@implementation BSCoreDataStackManager

#pragma mark - Custom Getters and Setters

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self) {
        if (_persistentContainer == nil)
        {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WagDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
                
            }];
        }
    }
    
    return _persistentContainer;
}

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Singleton

+ (nonnull instancetype)sharedManager
{
    static dispatch_once_t predicate;
    static BSCoreDataStackManager *shared = nil;
    
    dispatch_once(&predicate, ^{
        
        shared = [[[self class] alloc] init];
        
    });
    
    return shared;
}

@end
