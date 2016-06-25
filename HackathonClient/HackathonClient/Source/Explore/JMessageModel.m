//
//  JMessageModel.m
//  HackathonClient
//
//  Created by 蔡杰Alan on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "JMessageModel.h"

@implementation JMessageModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             
             @"messageId" : @"id",
             @"live_desc"  : @"live_desc",
             @"live_img":@"live_img",
             @"live_title":@"live_title",
             @"room":@"room",
             @"status":@"status",
             @"time":@"time",
             @"user":@"user",
             @"mail":@"mail"
             };
}

@end
