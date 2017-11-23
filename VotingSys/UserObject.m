//
//  UserObject.m
//  VotingSys
//
//  Created by GerryLin on 22/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import "UserObject.h"
#import "DataBaseObject.h"

static UserObject *sharedInstance = nil;

@implementation UserObject
@synthesize LoginState,UserID,Password;
+ (UserObject *)sharedInstance {
    if (sharedInstance != nil) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedInstance = [[UserObject alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        //initialization environment
        [self InitUserLogin];
    }
    return self;
}

- (void) InitUserLogin{
    [[DataBaseObject sharedInstance]getUserInfo:^(BOOL success, NSMutableArray *record) {
        if (record.count == 1) {
            NSMutableDictionary *userdata = [[NSMutableDictionary alloc]init];
            userdata = [record objectAtIndex:0];
            UserID = [userdata objectForKey:@"username"];
            Password = [userdata objectForKey:@"userpassword"];
            LoginState = [userdata objectForKey:@"loginstate"];
        }
        else{
            LoginState = [NSNumber numberWithInt:2];
        }
    }];
}

@end
