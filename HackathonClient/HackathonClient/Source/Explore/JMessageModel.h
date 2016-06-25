//
//  JMessageModel.h
//  HackathonClient
//
//  Created by 蔡杰Alan on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Mantle.h"

@interface JMessageModel : MTLModel<MTLJSONSerializing>



@property (nonatomic,copy) NSString *messageId;

@property (nonatomic,copy) NSString *user;

@property (nonatomic,copy) NSString *room;

@property (nonatomic,copy) NSString *status;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *live_title;

@property (nonatomic,copy) NSString *live_img;

@property (nonatomic,copy) NSString *live_desc;


@property(nonatomic,strong)NSMutableArray *messageBigPics;

@property(nonatomic,strong)NSArray<NSString *> *mail;


@end
