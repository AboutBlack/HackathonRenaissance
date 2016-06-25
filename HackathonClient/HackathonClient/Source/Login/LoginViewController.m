//
//  LoginViewController.m
//  HackathonClient
//
//  Created by Yuqing Zhang on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "Header.h"

@interface LoginViewController ()
- (IBAction)loginButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    [self checkoutUserIsValid];
}


- (void)checkoutUserIsValid
{
    NSString *userName = self.userName.text;
    NSString *password = self.password.text;
    
    if (userName == nil || userName.length < 1 || password == nil || password.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"用户名或者密码不合法" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSDictionary *dict = @{@"user":userName,@"pass":password};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak LoginViewController *weakSelf = self;
    [manager POST:@"http://hack2016.applinzi.com/Home/Index/Login" parameters:dict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        // 成功;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kHas_User_Login];
        [[NSUserDefaults standardUserDefaults]setObject:userName forKey:kUser_Name];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if (weakSelf.block) {
            weakSelf.block();
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
- (IBAction)forgetPasswordClick:(id)sender {
    
}
@end
