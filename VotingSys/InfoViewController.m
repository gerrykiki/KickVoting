//
//  InfoViewController.m
//  VotingSys
//
//  Created by GerryLin on 22/11/2017.
//  Copyright © 2017 GerryLin. All rights reserved.
//

#import "InfoViewController.h"
#import "UserObject.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize AlertView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AlertView setBackgroundColor:[UIColor grayColor]];
    [self.EnterBtn addTarget:self action:@selector(GoToIndex:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)GoToIndex:(id)sender{
    [UserObject sharedInstance].LoginState = [NSNumber numberWithInt:0];
    [self dismissViewControllerAnimated:YES completion:nil];
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
