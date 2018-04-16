//
//  Constants.h
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

// Libraries
@import Foundation;

#pragma mark - Enums

typedef NS_ENUM(NSInteger, BSNetworkOperationStatus) {
    BSNetworkOperationStatusUnknown = 0,
    BSNetworkOperationStatusDownloading,
    BSNetworkOperationStatusNoActivity,
};

#pragma mark - Notifications

FOUNDATION_EXPORT NSString *const BSNotificationUsersDownloadStatusDidChange;
FOUNDATION_EXPORT NSString *const BSNotificationUserListDidChange;
FOUNDATION_EXPORT NSString *const BSNotificationImageDownloadStatusDidChange;

#pragma mark - Notification Payload Keys

FOUNDATION_EXPORT NSString *const BSPayloadKeyImageURLString;
