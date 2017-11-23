//
//  IndexViewController.m
//  VotingSys
//
//  Created by GerryLin on 21/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import "IndexViewController.h"
#import "SWRevealViewController.h"
#import "LoginInViewController.h"
#import "UserObject.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewWillAppear:(BOOL)animated{
    if ([[UserObject sharedInstance].LoginState intValue] == 2) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *controller = (UINavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginNVC"];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:controller animated:YES completion:nil];
    }
    else if([[UserObject sharedInstance].LoginState intValue] == 1){
        //Login in background and Go to InfoView
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *controller = (UINavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginPass"];
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:controller animated:YES completion:nil];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
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
