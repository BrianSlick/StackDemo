//
//  AppDelegate.m
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "AppDelegate.h"

// Other Global
#import "BSCoreDataStackManager.h"

// View Controllers
#import "BSUsersViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Wake up the Core Data stack
    [[BSCoreDataStackManager sharedManager] persistentContainer];
    
    // Set up UI
    
    BSUsersViewController *userViewController = [[BSUsersViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userViewController];
    [self setNavigationController:navigationController];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindow:window];

    [window setRootViewController:navigationController];
    [window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[BSCoreDataStackManager sharedManager] saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[BSCoreDataStackManager sharedManager] saveContext];
}

@end
