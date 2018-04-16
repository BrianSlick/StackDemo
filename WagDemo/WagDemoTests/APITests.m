//
//  APITests.m
//  WagDemoTests
//
//  Created by Brian Slick on 4/11/18.
//  Copyright © 2018 Brian Slick. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BSStackOverflowAPIVendor.h"

@interface APITests : XCTestCase

@end

@implementation APITests

- (void)setUp
{
    [super setUp];

}

- (void)tearDown
{
    [super tearDown];
    
}

- (void)testUsersEndpoint
{
    NSURL *sourceURL = [NSURL URLWithString:@"https://api.stackexchange.com/2.2/users?site=stackoverflow"];
    NSURL *testURL = [BSStackOverflowAPIVendor usersURL];
    
    XCTAssertEqualObjects(sourceURL, testURL, @"The URLs did not match");
}

@end
