//
//  NSString+Hack.m
//  HackathonClient
//
//  Created by Yuqing Zhang on 16/6/26.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "NSString+Hack.h"

@implementation NSString (Hack)
+ (BOOL)isEmptyString:(NSString *)str
{
    if (str== nil || str.length == 0 || [str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}
@end
