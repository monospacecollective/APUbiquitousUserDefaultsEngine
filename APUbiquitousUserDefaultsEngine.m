//
//  APUbiquitousUserDefaultsEngine.m
//  Squirrel
//
//  Created by Axel Péju on 26/12/11.
//  Copyright (c) 2011 Axel Péju. All rights reserved.
//

#import "APUbiquitousUserDefaultsEngine.h"

@interface APUbiquitousUserDefaultsEngine () {
@private
    id ap_ubiquitousKeyValueStoreObserver;
    id ap_userDefaultsObserver;
}

// Ubiquitous keys validation
- (BOOL)ap_ubiquitousKeysValid;

@end

@implementation APUbiquitousUserDefaultsEngine

@synthesize ubiquitousKeys = ap_ubiquitousKeys;

+ (APUbiquitousUserDefaultsEngine *)sharedEngine {
    static APUbiquitousUserDefaultsEngine * sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEngine = [[APUbiquitousUserDefaultsEngine alloc] init];
    });
    return sharedEngine;
}

- (void)dealloc {
    [self stop];
}

- (BOOL)pullUserDefaultsFromiCloud {
    BOOL success = [self ap_ubiquitousKeysValid];
    
    if(success) {
        NSSet * ubiquitousKeys = [self ubiquitousKeys];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSUbiquitousKeyValueStore * keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
        [ubiquitousKeys enumerateObjectsUsingBlock:^(NSString * key, BOOL *stop) {
            [userDefaults setObject:[keyValueStore objectForKey:key] forKey:key];
        }];
    }
    return success;
}

- (BOOL)pushUserDefaultsToiCloud {
    BOOL success = [self ap_ubiquitousKeysValid];
    
    if(success) {
        NSSet * ubiquitousKeys = [self ubiquitousKeys];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSUbiquitousKeyValueStore * keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
        [ubiquitousKeys enumerateObjectsUsingBlock:^(NSString * key, BOOL *stop) {
            [keyValueStore setObject:[userDefaults objectForKey:key] forKey:key];
        }];
    }
    return success;
}

- (BOOL)start {
    NSUbiquitousKeyValueStore * keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    // Observe the values in iCloud
    ap_ubiquitousKeyValueStoreObserver = [center addObserverForName:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                             object:keyValueStore
                                                              queue:nil
                                                         usingBlock:^(NSNotification *note) {
                                                             NSDictionary * userInfo = [note userInfo];
                                                             NSArray * changedKeys = [userInfo valueForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
                                                             NSMutableSet * relevantKeys = [NSMutableSet setWithArray:changedKeys];
                                                             [relevantKeys intersectSet:[self ubiquitousKeys]];
                                                             
                                                             // Pull values from iCloud
                                                             [relevantKeys enumerateObjectsUsingBlock:^(NSString * key, BOOL *stop) {
                                                                 [userDefaults setObject:[keyValueStore objectForKey:key] forKey:key];
                                                             }];
                                                         }];
    
    // Observe changes in the user defaults
    ap_userDefaultsObserver = [center addObserverForName:NSUserDefaultsDidChangeNotification
                                                  object:userDefaults
                                                   queue:nil
                                              usingBlock:^(NSNotification *note) {
                                                  if([self ap_ubiquitousKeysValid]) {
                                                      // Push values to iCloud
                                                      [[self ubiquitousKeys] enumerateObjectsUsingBlock:^(NSString * key, BOOL *stop) {
                                                          [keyValueStore setObject:[userDefaults objectForKey:key] forKey:key];
                                                      }];
                                                      
                                                      // Save changes
                                                      [keyValueStore synchronize];
                                                  }
                                              }];
    
    // Pull values from the cloud as initial sync
    [self pullUserDefaultsFromiCloud];
    
    return YES;
}

- (BOOL)stop {
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    if(ap_ubiquitousKeyValueStoreObserver) {
        [center removeObserver:ap_ubiquitousKeyValueStoreObserver];
    }
    if(ap_userDefaultsObserver) {
        [center removeObserver:ap_userDefaultsObserver];
    }
    return YES;
}

#pragma mark
#pragma mark Ubiquitous keys validation

// Returns NO if keys are not strings, or if at least one of the user defaults is nil
- (BOOL)ap_ubiquitousKeysValid {
    NSSet * ubiquitousKeys = [self ubiquitousKeys];
    
    __block BOOL success = YES;
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [ubiquitousKeys enumerateObjectsUsingBlock:^(NSString * key, BOOL *stop) {
        if(![key isKindOfClass:[NSString class]] || ![userDefaults objectForKey:key]) {
            success = NO;
        }
    }];
    return success;
}

@end
