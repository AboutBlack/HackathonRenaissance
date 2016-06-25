//
//  LiveViewController.m
//  HackathonClient
//
//  Created by 孙恺 on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "LiveViewController.h"
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

@interface LiveViewController ()

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (IBAction)hangUp:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}




@end
