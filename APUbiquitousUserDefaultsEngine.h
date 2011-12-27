//
//  APUbiquitousUserDefaultsEngine.h
//  Squirrel
//
//  Created by Axel Péju on 26/12/11.
//  Copyright (c) 2011 Axel Péju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APUbiquitousUserDefaultsEngine : NSObject

// Ubiquitous user defaults keys
@property (strong) NSSet * ubiquitousKeys;

+ (APUbiquitousUserDefaultsEngine *)sharedEngine;

// Pulls the values registered in iCloud, and sets it to the user defaults
- (BOOL)pullUserDefaultsFromiCloud;

// Pushes the specified values of the users defaults to iCloud
- (BOOL)pushUserDefaultsToiCloud;

// Starts syncing the specified keys with iCloud
- (BOOL)start;

// Stops syncing
- (BOOL)stop;

@end
