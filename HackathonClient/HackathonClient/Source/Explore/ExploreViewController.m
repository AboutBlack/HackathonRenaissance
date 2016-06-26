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
#import "PublicViewController.h"
#import "MJRefresh.h"
#import "Mantle.h"
#import "AFNetworking.h"
#import "CYLTableViewPlaceHolder.h"
#import "WeChatStylePlaceHolder.h"
#import "Header.h"
#import "WatchViewController.h"


static  NSString * const kJMessageIdentify =  @"kJMessageIdentify";

@interface ExploreViewController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate,WeChatStylePlaceHolderDelegate>

@property (nonatomic,strong) UITableView *exploreTableView;

@property (nonatomic,strong) NSMutableArray<JMessageModel*> *dataSource;

@end

@implementation ExploreViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"探索";
    
    UIButton *publicButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 44)];
    [publicButton setTitle:@"发布" forState:UIControlStateNormal];
    [publicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [publicButton addTarget:self action:@selector(publicButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:publicButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    self.exploreTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.exploreTableView registerClass:[JMessageCell class] forCellReuseIdentifier:kJMessageIdentify];
    self.exploreTableView.delegate = self;
    self.exploreTableView.dataSource = self;
    
    self.exploreTableView.tableFooterView = ({
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.exploreTableView.frame), 50)];
        bg;
    });
    
    [self.view addSubview:self.exploreTableView];
    
    [self.exploreTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
    
    self.exploreTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerWithRefreshing)];
    
    // Enter the refresh status immediately
    [self.exploreTableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shouldRefreshData) name:kShouldRefreshData object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark --Action
-(void)headerWithRefreshing{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = @"http://hack2016.applinzi.com/Home/Index/livelist";
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事--%@",responseObject);
        
       // NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [self.dataSource removeAllObjects];
        
        for (NSDictionary *dic in responseObject) {
         
            
            JMessageModel *model = [MTLJSONAdapter modelOfClass:[JMessageModel class] fromJSONDictionary:dic error:nil];
            
            if (model) {
                [self.dataSource addObject:model];
            }
        }
        
        [self.exploreTableView.mj_header endRefreshing];

        
//        if ([self.dataSource count] > 0 ) {
//            [self.exploreTableView cyl_reloadData];
//        }
        
        [self.exploreTableView cyl_reloadData];

        
        
    
    }
     
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
        [self.exploreTableView.mj_header endRefreshing];
             
         }];
    NSLog(@"下拉刷新");
//    [self.exploreTableView.mj_header endRefreshing];
//    [self.exploreTableView reloadData];

}

#pragma mark -- UITableViewDelegate && DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return 3;
    
    return [self.dataSource count];
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row < [self.dataSource count]) {
    
        JMessageModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        
        WatchViewController *watch = [[WatchViewController alloc] init];
        [self presentViewController:watch animated:YES completion:nil];
        

    }
    
    
}

#pragma mark --data
- (UIView *)makePlaceHolderView {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.exploreTableView.frame];
    weChatStylePlaceHolder.delegate = self;
    return weChatStylePlaceHolder;
}

#pragma mark - WeChatStylePlaceHolderDelegate Method

- (void)emptyOverlayClicked:(id)sender {
    [self.exploreTableView.mj_header beginRefreshing];
}


-(void)publicButtonClick
{
    PublicViewController *public = [[PublicViewController alloc]init];
    [self.navigationController pushViewController:public animated:YES];
}

- (void)shouldRefreshData
{
    [self.exploreTableView.mj_header beginRefreshing];
}
@end
