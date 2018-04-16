//
//  BSUsersTableViewCell.m
//  WagDemo
//
//  Created by Brian Slick on 4/12/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import "BSUsersTableViewCell.h"

// Other Global

// Managers
#import "BSImageDataManager.h"

// Models
#import "BSStackOverflowUser+CoreDataClass.h"
#import "BSImageInfo+CoreDataClass.h"

@interface BSUsersTableViewCell ()

// Private Properties
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *bronzeLabel;
@property (nonatomic, strong) IBOutlet UILabel *silverLabel;
@property (nonatomic, strong) IBOutlet UILabel *goldLabel;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation BSUsersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Public Methods

- (void)populateWithUser:(BSStackOverflowUser *)user
{
    [[self nameLabel] setText:[user displayName]];
    
    NSInteger goldPoints = [[user badgeGold] integerValue];
    NSInteger silverPoints = [[user badgeSilver] integerValue];
    NSInteger bronzePoints = [[user badgeBronze] integerValue];
        
    [[self goldLabel] setHidden:(goldPoints == 0)];
    [[self goldLabel] setText:[NSString stringWithFormat:@"%ld", goldPoints]];
    
    [[self silverLabel] setHidden:(silverPoints == 0)];
    [[self silverLabel] setText:[NSString stringWithFormat:@"%ld", silverPoints]];

    [[self bronzeLabel] setHidden:(bronzePoints == 0)];
    [[self bronzeLabel] setText:[NSString stringWithFormat:@"%ld", bronzePoints]];

    BSImageDataManager *imageDataManager = [BSImageDataManager sharedManager];
    
    BSImageInfo *imageInfo = [user imageInfo];
    
    BOOL isDownloading = [imageDataManager isDownloadingImageForImageInfo:imageInfo];

    if (isDownloading)
    {
        if ([[self spinner] isAnimating] == NO)
        {
            [[self spinner] startAnimating];
        }
        
        UIImage *image = [UIImage imageNamed:@"placeholder"];
        [[self avatarImageView] setImage:image];
    }
    else
    {
        [[self spinner] stopAnimating];

        if ([imageDataManager isLocalImageAvailableForImageInfo:imageInfo] == NO)
        {
            [imageDataManager downloadImageForImageInfo:imageInfo];
        }
        
        UIImage *image = [BSImageDataManager imageForImageInfo:imageInfo];
        [[self avatarImageView] setImage:image];
    }
}


@end
