//
//  JGridView.h
//  HackathonClient
//
//  Created by 蔡杰Alan on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import <UIKit/UIKit.h>

///九宫格图片间隔
#define kJGG_GAP 5
/**
 *
 *  @param index      点击index
 *  @param dataSource 数据源
 */
typedef void (^TapBlcok)(NSInteger index,NSArray *dataSource);

@interface JGridView : UIView


/**
 * 九宫格数据源
 */
@property (nonatomic, strong)NSArray * dataSource;
/**
 *  TapBlcok
 */
@property (nonatomic, copy)TapBlcok  tapBlock;

/**
 *  Description 九宫格
*/
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource completeBlock:(TapBlcok )tapBlock;


/**
 *  Description 九宫格
 
 */
-(void)JGridView:(JGridView *)jggView DataSource:(NSArray *)dataSource completeBlock:(TapBlcok)tapBlock;

/**
 *  配置图片的宽（正方形，宽高一样）
 *
 *  @return 宽
 */
+(CGFloat)imageWidth;
/**
 *  配置图片的高（正方形，宽高一样）
 *
 *  @return 高
 */
+(CGFloat)imageHeight;



@end
