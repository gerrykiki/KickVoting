//
//  DataBaseObject.m
//  WaterlineCoasterTest
//
//  Created by Po wei Lin on 18/10/2017.
//  Copyright © 2017 Wistron. All rights reserved.
//

#import "DataBaseObject.h"
static DataBaseObject *sharedInstance = nil;

@implementation DataBaseObject

+ (DataBaseObject *)sharedInstance {
    if (sharedInstance != nil) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedInstance = [[DataBaseObject alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

-(BOOL) createDatabase:(NSString *)databaseName{
    NSString *docsDir;
    NSArray *dirPath;
    sqlite3 *db;
    
    // Get the documents directory
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPath objectAtIndex:0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: databaseName]];
    _database_filepath = databasePath;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK) {
            char *errMsg;
            // create SQL statements
            const char *sql = "CREATE TABLE IF NOT EXISTS USERTABLE (User TEXT PRIMARY KEY,Password TEXT,Loginstate INTEGER)";
            
            if (sqlite3_exec(db, sql, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog( @"Failed to create table");
                return NO;
            }
            sqlite3_close(db);
            return YES;
        }
        else {
            NSLog( @"Failed to open/create database");
            return NO;
        }
    }else{
        NSLog(@"Database already created.");
        return YES;
    }
}

- (int) addUser : (NSString *)User_id Password:(NSString *)password LoginState:(NSNumber *)loginstate{
    sqlite3* db = NULL;
    int rc=0;
    
    rc = sqlite3_open_v2([_database_filepath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE, NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString *query = [NSString stringWithFormat:@"INSERT INTO USERTABLE (User,Password,Loginstate) VALUES ('%@','%@',%d)", User_id,password,[loginstate intValue]];
        char * errMsg;
        rc = sqlite3_exec(db, query.UTF8String,NULL,NULL,&errMsg);
        
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to insert USERTABLE rc:%d, msg=%s",rc,errMsg);
        }
        
        sqlite3_close(db);
    }
    return rc;
}

- (int) deleteUserID {
    sqlite3* db = NULL;
    int rc=0;
    
    rc = sqlite3_open_v2([_database_filepath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE, NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString *query = @"DELETE FROM USERTABLE";
        char * errMsg;
        rc = sqlite3_exec(db, query.UTF8String,NULL,NULL,&errMsg);
        
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to delete user USERTABLE table rc:%d, msg=%s",rc,errMsg);
        }
        
        sqlite3_close(db);
    }
    
    return rc;
}

- (int) getUserInfo :(userid_query_complete)callback {
    sqlite3* db = NULL;
    sqlite3_stmt* stmt =NULL;
    int rc=0;
    NSMutableArray *userID_dataset = [[NSMutableArray alloc] init];
    
    rc = sqlite3_open_v2([_database_filepath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM 'USERTABLE'"];
        char * errMsg = NULL;
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        
        if(SQLITE_OK != rc)
        {
            NSLog(@"getUserID, Failed to create table rc:%d, msg=%s",rc,errMsg);
            callback(NO, nil);
        } else {
            while (sqlite3_step(stmt) == SQLITE_ROW) //get each row in loop
            {
                
                NSString * username =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
                NSString * userpassword =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSNumber * Loginstate =[NSNumber numberWithInt:sqlite3_column_int(stmt, 2)];
                NSDictionary *user_data =[NSDictionary dictionaryWithObjectsAndKeys:username,@"username",userpassword,@"userpassword",Loginstate,@"loginstate", nil];
                [userID_dataset addObject:user_data];
                
            }
            NSLog(@"Done");
            sqlite3_finalize(stmt);
        }
        
        sqlite3_close(db);
        callback(YES, userID_dataset);
    }
    
    return rc;
    
}

- (int) UpdateUserInfoLoginState : (NSNumber *)LoginState UserID : (NSString *)userid{
    sqlite3* db = NULL;
    int rc=0;
    
    rc = sqlite3_open_v2([_database_filepath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE, NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString *query = [NSString stringWithFormat:@"Update USERTABLE Set Loginstate='%@' Where User='%@'",LoginState,userid];
        char * errMsg;
        rc = sqlite3_exec(db, query.UTF8String,NULL,NULL,&errMsg);
        
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to insert USERTABLE rc:%d, msg=%s",rc,errMsg);
        }
        
        sqlite3_close(db);
    }
    return rc;
}

@end
