//
//  JMessageCell.m
//  HackathonClient
//
//  Created by 蔡杰Alan on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "JMessageCell.h"
#import "JMessageModel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"





@interface JCardView : UIView

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UILabel     *titleLabel;

@property (nonatomic,strong) UILabel     *priceLable;


@end

@implementation JCardView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 30, 30)];
        _imageView.backgroundColor = [UIColor cyanColor];
        
        [self addSubview:_imageView];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), 50, 15)];
        _titleLabel.font = [UIFont systemFontOfSize:8.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
        
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), 50, 10)];
        _priceLable.textAlignment = NSTextAlignmentCenter;
        _priceLable.font = [UIFont systemFontOfSize:10.0f];


        [self addSubview:_priceLable];
    }
    
    return self;
}

@end


#define kAvatar_Size 40

#define kGAP 10


@interface JMessageCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *timeLibel;



@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) JMessageModel *messageModel;

@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) UIView      *container;

@end

@implementation JMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.headImageView = [[UIImageView alloc] init];
        self.headImageView.backgroundColor = [UIColor whiteColor];
        self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(kGAP);
            make.width.height.mas_equalTo(kAvatar_Size);
        }];
        //      self.headImageView.clipsToBounds = YES;
        //      self.headImageView.layer.cornerRadius = kAvatar_Size/2;
        // nameLabel
        self.nameLabel = [UILabel new];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
        self.nameLabel.preferredMaxLayoutWidth = screenWidth - kGAP-kAvatar_Size - 2*kGAP;
        self.nameLabel.numberOfLines = 0;
        //        self.nameLabel.displaysAsynchronously = YES;
        self.nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
            make.top.mas_equalTo(self.headImageView);
            make.right.mas_equalTo(-kGAP);
        }];
        // desc
        self.descLabel = [UILabel new];
        //        self.descLabel.displaysAsynchronously = YES;
        self.descLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.contentView addSubview:self.descLabel];
        self.descLabel.preferredMaxLayoutWidth =screenWidth - kGAP-kAvatar_Size - 2*kGAP;
        self.descLabel.numberOfLines = 0;
        self.descLabel.font = [UIFont systemFontOfSize:14.0];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kGAP);
        }];
        
        self.timeLibel =  [UILabel new];
        self.timeLibel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.timeLibel];
        self.timeLibel.numberOfLines = 0;
        self.timeLibel.textAlignment = NSTextAlignmentRight;
        self.timeLibel.font = [UIFont systemFontOfSize:14.0];
        [self.timeLibel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.nameLabel.mas_top);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(self.nameLabel);
        }];

        

        
        
        self.bgImageView = [UIImageView new];
        [self.contentView addSubview:self.bgImageView];
        
       // self.backgroundColor = [UIColor redColor];
        
        self.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLabel);
            make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kGAP);
            make.height.mas_equalTo(180);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-(2*kAvatar_Size));
        }];
        
        //([UIScreen mainScreen].bounds.size.width-(2*kGAP+kAvatar_Size)*2);
        self.scrollView = [UIScrollView new];
       
        [self.contentView addSubview:self.scrollView];
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            //设置边界约束
            make.left.mas_equalTo(self.bgImageView.mas_left).offset(0);
            make.width.mas_equalTo(self.bgImageView.mas_width);
            make.height.equalTo(@60);
            make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(0);
            
        }];
        
        //创建ScrollView子视图容器视图
        self.container = [[UIView alloc] init];
         self.container.backgroundColor = [UIColor greenColor];
        [self.scrollView addSubview: self.container];
        //
        //    //添加container约束
        [ self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);//边界紧贴ScrollView边界
            //make.width.equalTo(self.scrollView);//宽度和ScrollView相等
        }];
        
        
        
       
        
        

//
        
        self.hyb_lastViewInCell = self.bgImageView;
        self.hyb_bottomOffsetToCell = 10.0;
        
       
    }
    
    return self;
}

- (void)configCellWithModel:(JMessageModel *)model indexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
    self.nameLabel.text = model.user;
    self.descLabel.text = model.live_desc;
    self.timeLibel.text = [NSString stringWithFormat:@"直播时间:%@",model.time];;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.live_img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.messageModel = model;
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    muStyle.lineSpacing = 2;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0],NSParagraphStyleAttributeName:muStyle};
  //  CGFloat h = [self.descLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - kGAP-kAvatar_Size - 2*kGAP, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.live_img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    CGFloat jjg_height = 0.0;
    CGFloat jjg_width = 0.0;
    
    if (model.messageBigPics == nil) {
        
        model.messageBigPics = [[NSMutableArray alloc] init];
    }
    
    [model.messageBigPics addObject:model.live_img];
    
    if (model.messageBigPics.count>0&&model.messageBigPics.count<=3) {
        jjg_height = [JGridView imageHeight];
        jjg_width  = (model.messageBigPics.count)*([JGridView imageWidth]+kJGG_GAP)-kJGG_GAP;
    }else if (model.messageBigPics.count>3&&model.messageBigPics.count<=6){
        jjg_height = 2*([JGridView imageHeight]+kJGG_GAP)-kJGG_GAP;
        jjg_width  = 3*([JGridView imageWidth]+kJGG_GAP)-kJGG_GAP;
    }else  if (model.messageBigPics.count>6&&model.messageBigPics.count<=9){
        jjg_height = 3*([JGridView imageHeight]+kJGG_GAP)-kJGG_GAP;
        jjg_width  = 3*([JGridView imageWidth]+kJGG_GAP)-kJGG_GAP;
    }
//    [self.jggView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.jggView JGridView:self.jggView DataSource:model.messageBigPics completeBlock:^(NSInteger index, NSArray *dataSource) {
//        self.tapBlock(index,dataSource);
//    }];
//    [self.jggView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.descLabel);
//        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kJGG_GAP);
//        make.size.mas_equalTo(CGSizeMake(jjg_width, jjg_height));
//    }];
    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        //设置边界约束
//        make.edges.equalTo(self.jggView).with.insets(UIEdgeInsetsMake(5,5,5,5));
//    }];
    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        //设置边界约束
//        make.left.mas_equalTo(self.jggView.mas_left).offset(0);
//        make.right.mas_equalTo(self.jggView.mas_right).offset(0);
//        make.bottom.mas_equalTo(self.jggView.mas_bottom).offset(0);
//        make.height.equalTo(@60);
//        make.width.mas_equalTo(@(jjg_width));
//        
//    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descLabel);
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kGAP);
        make.height.mas_equalTo(180);
    make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width-(2*kAvatar_Size));
    }];
    
    //创建ScrollView子视图容器视图
    
//    
//    //添加container约束
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);//边界紧贴ScrollView边界
//        make.width.equalTo(self.scrollView);//宽度和ScrollView相等
    }];

    
    NSInteger count = [model.mail count];
    
    //向container添加多个View
    JCardView *lastView = nil;
    for(int i = 0;i <count;++i ){
        self.scrollView.backgroundColor = [UIColor grayColor];
        self.scrollView.alpha = 0.8;
        //创建一个View
        JCardView *subView = [[JCardView alloc] initWithFrame:CGRectMake(0, 0, 50, 80)];
        
        NSString *url = [((NSDictionary*)[model.mail objectAtIndex:i]) objectForKey:@"img"];
    [subView.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        NSString *price = [((NSDictionary*)[model.mail objectAtIndex:i]) objectForKey:@"price"];
        
        NSString *title = [((NSDictionary*)[model.mail objectAtIndex:i]) objectForKey:@"title"];
        
        subView.titleLabel.text = title;
        subView.priceLable.text = [NSString stringWithFormat:@"%@元",price];

        
        [self.container addSubview:subView];
        //颜色随机
//        subView.backgroundColor = [UIColor colorWithRed:( arc4random() % 256 / 256.0 )
//                                                  green:( arc4random() % 256 / 256.0 )
//                                                   blue:( arc4random() % 256 / 256.0 )
                                                 // alpha:1];
        
        
        
        
        CGRect frame = subView.frame;
        
        if ( lastView ) {
            frame.origin.x = CGRectGetMaxX(lastView.frame)+6;
        
        } else {
            frame.origin.x = 0;
        
        
        }
        
        subView.frame = frame;
        
        
        //向subView添加约束
//        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.container.mas_centerY).offset(0);//左container紧贴
//            make.height.mas_equalTo(70);//高度随i递增
//            make.width.mas_equalTo(50);
//            //判断是否有前一个子View
//            if ( lastView ) {
//                make.left.mas_equalTo(lastView.mas_right).offset(6);
//            } else {
//                make.left.mas_equalTo(self.container.mas_left);
//            }
//        }];
        //保存前一个View
        lastView = subView;
    }
    //添加container的最后一个约束
//    [self.container mas_updateConstraints:^(MASConstraintMaker *make) {
//        //container的下边界和最后一个View的下边界紧贴
//        make.right.equalTo(lastView.mas_right);
//    }];
    
    
   
}






@end
