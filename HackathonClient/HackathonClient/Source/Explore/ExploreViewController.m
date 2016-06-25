//
//  ExploreViewController.m
//  HackathonClient
//
//  Created by 孙恺 on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "ExploreViewController.h"
#import "JMessageCell.h"
#import "JMessageModel.h"
#import "Masonry.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"


static  NSString * const kJMessageIdentify =  @"kJMessageIdentify";

@interface ExploreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *exploreTableView;

@property (nonatomic,strong) NSMutableArray<JMessageModel*> *dataSource;

@end

@implementation ExploreViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"Explore";
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    self.exploreTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.exploreTableView registerClass:[JMessageCell class] forCellReuseIdentifier:kJMessageIdentify];
    self.exploreTableView.delegate = self;
    self.exploreTableView.dataSource = self;
    
    [self.view addSubview:self.exploreTableView];
    
    [self.exploreTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.exploreTableView reloadData];
}


#pragma mark -- UITableViewDelegate && DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
   // return [self.dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (!cell) {
        cell = [[JMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageCell"];
        //cell.delegate = self;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    __weak __typeof(self) weakSelf= self;
    __weak __typeof(_exploreTableView) weakTable= _exploreTableView;
    __weak __typeof(cell) weakCell= cell;
    
    __weak __typeof(window) weakWindow= window;
    
    __block JMessageModel *model = nil;
    
    
    if (indexPath.row < [self.dataSource count]) {
        
        model = [self.dataSource objectAtIndex:indexPath.row];

    }
    
    
    
    [cell configCellWithModel:model indexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    
    //九宫格
    cell.tapBlock = ^(NSInteger index,NSArray *dataSource){
        
//        //1.创建图片浏览器
//        MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
//        NSMutableArray *photosArray = [NSMutableArray array];
//        //2.告诉图片浏览器显示所有的图片
//        for (int i = 0 ; i < dataSource.count; i++) {
//            //传递数据给浏览器
//            MJPhoto *photo = [[MJPhoto alloc] init];
//            photo.url = [NSURL URLWithString:dataSource[i]];
//            photo.srcImageView = weakCell.jggView.subviews[i]; //设置来源哪一个UIImageView
//            [photosArray addObject:photo];
//        }
//        brower.photos = photosArray;
//        brower.currentPhotoIndex = index;
//        [brower show];
    };
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMessageModel *model = nil;
    
    
    if (indexPath.row < [self.dataSource count]) {
        model = [self.dataSource objectAtIndex:indexPath.row];

    }
    
    
    CGFloat h = [JMessageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        JMessageCell *cell = (JMessageCell *)sourceCell;
        [cell configCellWithModel:model indexPath:indexPath];
    } cache:^NSDictionary *{
        NSDictionary *cache = @{kHYBCacheUniqueKey : @"123123",
                                kHYBCacheStateKey  : @"",
                                kHYBRecalculateForStateKey : @(NO)};
        //model.shouldUpdateCache = NO;
        return cache;
    }];
    return h;
}




@end
