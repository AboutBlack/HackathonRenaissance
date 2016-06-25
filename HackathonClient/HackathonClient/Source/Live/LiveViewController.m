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

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Action

- (IBAction)hangUp:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark - Status Bar

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}




@end
