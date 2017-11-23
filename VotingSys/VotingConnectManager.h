//
//  VotingConnectManager.h
//  VotingSys
//
//  Created by GerryLin on 22/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^datarequestComplete) (BOOL success, NSDictionary *result);

@interface VotingConnectManager : NSObject<NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) NSURLSessionConfiguration *configuration;
@property (strong, nonatomic) NSURLSession *session;

+ (instancetype)sharedInstance;
- (void) getWebserviceWithParameter : (NSDictionary *)param ObjectWithCommand:(NSString *)command token:(NSString *)token complete:(datarequestComplete)callback;

@end
