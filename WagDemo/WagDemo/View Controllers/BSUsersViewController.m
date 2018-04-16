//
//  BSUsersViewController.m
//  WagDemo
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSUsersViewController.h"

// Other Global
#import "Constants.h"

// Managers
#import "BSUserDataManager.h"
#import "BSNetworkManager.h"

// Categories

// Models
#import "BSStackOverflowUser+CoreDataClass.h"

// Data Sources
#import "BSUsersDataSource.h"

// View Controllers

// Views
#import "BSUsersTableViewCell.h"

// Private Constants


@interface BSUsersViewController () <UITableViewDataSource, UITableViewDelegate>

// Private Properties
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *refreshButton;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@property (nonatomic, strong) BSUsersDataSource *dataSource;

@end

@implementation BSUsersViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Custom Getters and Setters

- (BSUsersDataSource *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [[BSUsersDataSource alloc] init];
    }
    return _dataSource;
}

#pragma mark - Initialization and UI Creation Methods


#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[self navigationController] setToolbarHidden:YES animated:YES];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self selector:@selector(userListDidChange:) name:BSNotificationUserListDidChange object:nil];
    [notificationCenter addObserver:self selector:@selector(usersDownloadStatusDidChange:) name:BSNotificationUsersDownloadStatusDidChange object:nil];
    [notificationCenter addObserver:self selector:@selector(imageInfoStatusDidChange:) name:BSNotificationImageDownloadStatusDidChange object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    BSUsersDataSource *dataSource = [self dataSource];
    
    [dataSource reload];
    
    if ([dataSource numberOfUsers] == 0)
    {
        [[BSUserDataManager sharedManager] downloadAndProcessUsers];
    }
    
    [self refreshUserInterface];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:BSNotificationUserListDidChange object:nil];
    [notificationCenter removeObserver:self name:BSNotificationUsersDownloadStatusDidChange object:nil];
    [notificationCenter removeObserver:self name:BSNotificationImageDownloadStatusDidChange object:nil];
}

#pragma mark - Notification Handlers

- (void)userListDidChange:(NSNotification *)notification
{
    [self refreshUserInterface];
}

- (void)usersDownloadStatusDidChange:(NSNotification *)notification
{
    [self refreshButtonStatus];
}

- (void)imageInfoStatusDidChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString *urlString = [userInfo objectForKey:BSPayloadKeyImageURLString];
    
    NSIndexPath *indexPath = [[self dataSource] indexPathOfUserInfoWithRemoteImageURLString:urlString];
    
    BSStackOverflowUser *user = [[self dataSource] userAtIndex:[indexPath row]];
    BSUsersTableViewCell *cell = (BSUsersTableViewCell *)[[self tableView] cellForRowAtIndexPath:indexPath];
    
    [cell populateWithUser:user];
}

#pragma mark - UI Response Methods

- (void)refreshButtonTapped:(UIBarButtonItem *)button
{
    [[BSUserDataManager sharedManager] deleteAllUsers];
    
    [[BSUserDataManager sharedManager] downloadAndProcessUsers];
}

#pragma mark - Misc Methods

- (void)setupUserInterface
{
    // Navigation bar setup
    
    [self setTitle:@"SO Users"];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                   target:self
                                                                                   action:@selector(refreshButtonTapped:)];
    [self setRefreshButton:refreshButton];
    [[self navigationItem] setRightBarButtonItem:refreshButton];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner setHidesWhenStopped:YES];
    [self setSpinner:spinner];
    
    UIBarButtonItem *activityButton = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    [[self navigationItem] setLeftBarButtonItem:activityButton];
    
    // Table view setup
    
    UITableView *tableView = [self tableView];
    
    [BSUsersTableViewCell registerNibForTableView:tableView];
    
    BSUsersTableViewCell *cell = [BSUsersTableViewCell dequeueCellFromTableView:tableView];
    [tableView setRowHeight:CGRectGetHeight([cell bounds])];
}

- (void)refreshUserInterface
{
    [[self dataSource] reload];
    
    [[self tableView] reloadData];
    
    [self refreshButtonStatus];
}

- (void)refreshButtonStatus
{
    BSNetworkOperationStatus networkStatus = [[BSNetworkManager sharedManager] usersNetworkOperationStatus];
    
    [[self refreshButton] setEnabled:(networkStatus != BSNetworkOperationStatusDownloading)];
    
    if (networkStatus == BSNetworkOperationStatusDownloading)
    {
        [[self spinner] startAnimating];
    }
    else
    {
        [[self spinner] stopAnimating];
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[self dataSource] numberOfUsers];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSUsersTableViewCell *cell = [BSUsersTableViewCell dequeueCellFromTableView:tableView];
    
    BSStackOverflowUser *user = [[self dataSource] userAtIndex:[indexPath row]];
    
    [cell populateWithUser:user];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
