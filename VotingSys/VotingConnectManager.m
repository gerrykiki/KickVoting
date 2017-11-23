//
//  VotingConnectManager.m
//  VotingSys
//
//  Created by GerryLin on 22/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import "VotingConnectManager.h"

static VotingConnectManager *sharedInstance = nil;

@implementation VotingConnectManager
@synthesize configuration,session;
+ (VotingConnectManager *)sharedInstance {
    if (sharedInstance != nil) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedInstance = [[VotingConnectManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    return self;
}

- (void)getWebserviceWithParameter:(NSDictionary *)param ObjectWithCommand:(NSString *)command token:(NSString *)token complete:(datarequestComplete)callback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://apis.juhe.cn/wifi/local"]];
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    if (token != nil) {
        [request addValue:token forHTTPHeaderField:@"Token"];
    }
    if (param) {
        NSData *param_data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:&error];
        
        [request setHTTPBody:param_data];
        
    }
    
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"get user info callback");
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *json_error;
        if (error) {
            callback(NO, nil);
        } else {
            NSMutableDictionary *request_dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&json_error];
            callback(YES, (NSMutableDictionary *)request_dictionary);
            //            callback(YES, (NSMutableDictionary *)[request_dictionary objectForKey:@"data"]);
        }
    }];
    
    [sessionTask resume];
    
}

@end
