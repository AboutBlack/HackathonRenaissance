//
//  LoginViewController.h
//  HackathonClient
//
//  Created by Yuqing Zhang on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHas_User_Login @"UserHasLogin"
typedef void(^loginBlock)(void);
@interface LoginViewController : UIViewController
- (IBAction)forgetPasswordClick:(id)sender;
@property (nonatomic,copy)loginBlock block;
@end
