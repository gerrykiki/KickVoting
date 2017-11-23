//
//  LoginInViewController.m
//  VotingSys
//
//  Created by GerryLin on 22/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import "LoginInViewController.h"
#import "VotingConnectManager.h"
#import "DataBaseObject.h"
#import "InfoViewController.h"
#import "UserObject.h"

@interface LoginInViewController ()

@end

@implementation LoginInViewController
@synthesize AccountText,PassWordText,LoginBtn;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"Wistron";
    [LoginBtn addTarget:self action:@selector(ClickTestBtn:) forControlEvents:UIControlEventTouchUpInside];
    [AccountText addTarget:self action:@selector(ReturnKeyClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [PassWordText addTarget:self action:@selector(ReturnKeyClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
    // Do any additional setup after loading the view.
}

- (void)ReturnKeyClick:(UITextField*)textField{
    [AccountText resignFirstResponder];
    [PassWordText resignFirstResponder];
}

- (void)ClickTestBtn:(id)sender{
    if ([self CheckAccount]) {
        int RC = [[DataBaseObject sharedInstance]deleteUserID];
        if (RC == 0) {
            [[DataBaseObject sharedInstance]addUser:AccountText.text Password:PassWordText.text LoginState:[NSNumber numberWithInt:1]];
            [self EnterNextView];
        }
    }
}

- (void)EnterNextView{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    InfoViewController *infoview = [storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
    [self.navigationController pushViewController:infoview animated:YES];
}

- (BOOL)CheckAccount{
    if ((unsigned long)[AccountText.text length] == 0) {
        NSLog(@"Email Wrong");
        return NO;
    }
    else if ((unsigned long)[PassWordText.text length] == 0){
        NSLog(@"Password Wrong");
        return NO;
    }
    else return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
