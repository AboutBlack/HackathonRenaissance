//
//  WatchViewController.h
//  HackathonClient
//
//  Created by 孙恺 on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGDChatCell.h"
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

@interface WatchViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, AgoraRtcEngineDelegate>

@property (nonatomic, assign) BOOL isFirstPresent;

@property (nonatomic, assign) NSUInteger userid;
@property (nonatomic, assign) NSUInteger roomid;
@property (nonatomic, assign) NSUInteger hostid;

@property(nonatomic,retain) NSDictionary *dictionary;

@property (assign, nonatomic) AGDChatType chatType;

@end

static NSString * const AGDKeyChannelKey = @"Channel";
static NSString * const AGDKeyChannelValue = @"222";

static NSString * const AGDKeyVendorKey = @"VendorKey";
static NSString * const AGDKeyVendorValue = @"27ab1f5329204bab8ea6863201f5fa6c";
