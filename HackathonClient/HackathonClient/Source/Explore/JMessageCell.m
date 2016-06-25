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



#define kAvatar_Size 40

#define kGAP 10


@interface JMessageCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *timeLibel;



@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) JMessageModel *messageModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

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

        

        
        
        self.jggView = [JGridView new];
        [self.contentView addSubview:self.jggView];
        [self.jggView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLabel);
            make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kGAP);
        }];
        self.hyb_lastViewInCell = self.jggView;
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
    [self.jggView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.jggView JGridView:self.jggView DataSource:model.messageBigPics completeBlock:^(NSInteger index, NSArray *dataSource) {
        self.tapBlock(index,dataSource);
    }];
    [self.jggView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descLabel);
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(kJGG_GAP);
        make.size.mas_equalTo(CGSizeMake(jjg_width, jjg_height));
    }];
    
   
    

}




@end
