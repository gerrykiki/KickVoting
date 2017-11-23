//
//  UserObject.h
//  VotingSys
//
//  Created by GerryLin on 22/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject

@property (strong, nonatomic) NSNumber *LoginState; //1:LogIn 2:LogOut
@property (strong, nonatomic) NSString *UserID;
@property (strong, nonatomic) NSString *Password;


+ (instancetype)sharedInstance;


@end
