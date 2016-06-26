//
//  ProfileViewController.m
//  HackathonClient
//
//  Created by 孙恺 on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "ProfileViewController.h"
#import "WatchViewController.h"

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(watch)];
    
//    self.navigationItem.rightBarButtonItem = btnItem;
}

- (void)watch {
    WatchViewController *watchVC = [[WatchViewController alloc] init];
    [self presentViewController:watchVC animated:true completion:^{
        
    }];
}
                                

@end
