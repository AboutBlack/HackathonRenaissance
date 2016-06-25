//
//  LoginViewController.m
//  HackathonClient
//
//  Created by Yuqing Zhang on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
- (IBAction)loginButtonClick:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonClick:(UIButton *)sender {
    if (self.block) {
        self.block();
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kHas_User_Login];
    }
}
@end
