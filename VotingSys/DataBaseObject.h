//
//  DataBaseObject.h
//  WaterlineCoasterTest
//
//  Created by Po wei Lin on 18/10/2017.
//  Copyright © 2017 Wistron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

typedef void (^userid_query_complete) (BOOL success, NSMutableArray *record);

@interface DataBaseObject : NSObject

@property (strong, nonatomic) NSString *database_filepath;

+ (DataBaseObject *)sharedInstance;
-(BOOL) createDatabase:(NSString *)databaseName;
- (int) addUser : (NSString *)User_id Password:(NSString *)password LoginState:(NSNumber *)loginstate;
- (int) deleteUserID;
- (int) getUserInfo :(userid_query_complete)callback;
- (int) UpdateUserInfoLoginState : (NSNumber *)LoginState UserID : (NSString *)userid;



@end
