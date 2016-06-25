//
//  JGridView.m
//  HackathonClient
//
//  Created by 蔡杰Alan on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "JGridView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#define kAvatar_Size 40

#define kGAP 10



@implementation JGridView


- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource completeBlock:(TapBlcok )tapBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSUInteger i=0; i<dataSource.count; i++) {
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0+([JGridView imageWidth]+kJGG_GAP)*(i%3),floorf(i/3.0)*([JGridView imageHeight]+kJGG_GAP),[JGridView imageWidth], [JGridView imageHeight])];
            if ([dataSource[i] isKindOfClass:[UIImage class]]) {
                iv.image = dataSource[i];
            }else if ([dataSource[i] isKindOfClass:[NSString class]]){
                [iv sd_setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }else if ([dataSource[i] isKindOfClass:[NSURL class]]){
                [iv sd_setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }
            self.dataSource = dataSource;
            self.tapBlock = tapBlock;// 一定要给self.tapBlock赋值
            iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
            iv.tag = i;
            [self addSubview:iv];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
            [iv addGestureRecognizer:singleTap];
        }
    }
    return self;
}
-(void)JGridView:(JGridView *)jggView DataSource:(NSArray *)dataSource completeBlock:(TapBlcok)tapBlock

{
    for (NSUInteger i=0; i<3; i++) {
        
        UIImageView *iv = [UIImageView new];
        
        if ([dataSource[i] isKindOfClass:[UIImage class]]) {
            iv.image = dataSource[i];
        }else if ([dataSource[i] isKindOfClass:[NSString class]]){
            [iv sd_setImageWithURL:[NSURL URLWithString:dataSource[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }else if ([dataSource[i] isKindOfClass:[NSURL class]]){
            [iv sd_setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        
        
        [iv sd_setImageWithURL:dataSource[i] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        jggView.dataSource = dataSource;
        jggView.tapBlock = tapBlock;
        iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
        iv.tag = i;
        [jggView addSubview:iv];
        
        
       // [JGridView n];
        //九宫格的布局
        CGFloat  Direction_X = (([JGridView imageWidth]+kJGG_GAP)*(i%3));
        CGFloat  Direction_Y  = (floorf(i/3.0)*([JGridView imageHeight]+kJGG_GAP));
        
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jggView).offset(Direction_X);
            make.top.mas_equalTo(jggView).offset(Direction_Y);
            make.size.mas_equalTo(CGSizeMake([JGridView imageWidth], [JGridView imageHeight]));
        }];
        
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:jggView action:@selector(tapImageAction:)];
//        [iv addGestureRecognizer:singleTap];
    }
    
}
#pragma mark
#pragma mark 配置图片的宽高
+(CGFloat)imageWidth{
    return ([UIScreen mainScreen].bounds.size.width-(2*kGAP+kAvatar_Size)*2)/3;
}
+(CGFloat)imageHeight{
    return ([UIScreen mainScreen].bounds.size.width-(2*kGAP+kAvatar_Size)*2)/3;
}
+(void)namedd{
    
}
-(void)tapImageAction:(UITapGestureRecognizer *)tap{
    UIImageView *tapView = (UIImageView *)tap.view;
    if (self.tapBlock) {
        self.tapBlock(tapView.tag,self.dataSource);
    }
}


@end
