//
//  JMessageCell.h
//  HackathonClient
//
//  Created by 蔡杰Alan on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JGridView.h"

@class JMessageModel;

@interface JMessageCell : UITableViewCell


@property (nonatomic, strong) JGridView *jggView;


/**
 *  浏览图片等block
 */
@property (nonatomic, copy)TapBlcok tapBlock;



- (void)configCellWithModel:(JMessageModel *)model indexPath:(NSIndexPath *)indexPath;

@end
