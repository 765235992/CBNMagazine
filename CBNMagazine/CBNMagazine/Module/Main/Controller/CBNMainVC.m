//
//  CBNMainVC.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNMainVC.h"
#import "MMDrawerBarButtonItem.h"
#import "CBNRecommendHeaderView.h"
#import "CBNNormalNewsCell.h"
#import "CBNVideoNewsCell.h"
#import "CBNRecommendNewsCell.h"
#import "CBNProjectArrayCell.h"
#import "CBNSegmentView.h"
#import "CBNSegmentModel.h"
#import "CBNChannelNetwork.h"
#import "CBNChannelNewsModel.h"
#import "CBNTextArticleDetailVC.h"
#import "CBNSetterVC.h"

#define navigation_Show  (float)(0.73*screen_Width -64)

static const CGFloat MJDuration = 1.0;

@interface CBNMainVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UIView *navigationView;
@property (nonatomic, strong) UITableView *aTableView;
@property (strong, nonatomic) NSMutableArray *sourceArray;
@property (nonatomic, strong) CBNRecommendHeaderView *headerView;
@property (nonatomic, strong) CBNSegmentView *segmentView;
@property (nonatomic, strong) CBNSegmentModel *channelItem;
@property (nonatomic, strong) CBNChannelNetwork *channelNetworkRequest;
@property (nonatomic, assign) CGFloat currentHeight;
@end

@implementation CBNMainVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGBColor(0, 0, 0, 0) andFrame:CGRectMake(0, 0, screen_Width, 64)]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.translucent=YES;

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationHeader];

    
    CBNSegmentModel *segmentiItem = [[CBNSegmentModel alloc] init];
    
//    segmentiItem.title = [channelInfo objectForKey:@"title"];
    
    segmentiItem.channelID = @"13";
    

    self.channelItem = segmentiItem;
    
    self.sourceArray = [[NSMutableArray alloc] init];
    
    
    [self setupTableView];
    [self.view addSubview:self.navigationView];
    _aTableView.mj_header = [CBNRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshChannelSource)];
    
    // 马上进入刷新状态
    [_aTableView.mj_header beginRefreshing];
    
//
}

- (void)loadDataFromCoreData
{
    
    for (int i = 0; i< 100; i++) {
        [self.sourceArray addObject:[NSNumber numberWithInt:i]];
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [_aTableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_aTableView.mj_header endRefreshing];
    });
}
- (void)refreshChannelSource
{
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    
//    dispatch_async(globalQueue, ^{
//        
//     
//        
//        dispatch_async(mainQueue, ^{
//            
//            [_aTableView reloadData];
//        });
//    });

    [self.sourceArray removeAllObjects];
    [self.aTableView reloadData];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
//    [self.aTableView.mj_header endRefreshing];
    [self.channelNetworkRequest cannelRequest];
    __weak typeof(self) wekSelf = self;
        [self.channelNetworkRequest loadChannelInfoWithChannelID:self.channelItem.channelID secuessed:^(id result) {
      
            NSLog(@"%@",result);
            
            int tempCount = 0;
            
            for (int i = 0; i < [[result objectForKey:@"article_list"] count]; i++) {
                
                NSDictionary *channelInfo = [[result objectForKey:@"article_list"] objectAtIndex:i];
                
                CBNChannelNewsModel *channelModel = [[CBNChannelNewsModel alloc]initWithChannelNewsInfo:channelInfo];
                
                [wekSelf.sourceArray addObject:channelModel];
            }
            // 刷新表格
            [wekSelf.aTableView reloadData];
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            [wekSelf.aTableView.mj_header endRefreshing];
    

    } failed:^(id error) {
        // 刷新表格
        [wekSelf.aTableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [wekSelf.aTableView.mj_header endRefreshing];

    }];
    
}
- (CBNChannelNetwork *)channelNetworkRequest
{
    if (!_channelNetworkRequest) {
        
        self.channelNetworkRequest = [[CBNChannelNetwork alloc] init];
        
        
    }
    
    return _channelNetworkRequest;
}


/*
 *  设置NavigationHeaderBar
 */
- (void)setNavigationHeader
{
    CBNBarBurronItem *leftBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(leftBar:) andFrame:CGRectMake(0, 0, 30, 30) andImage:[UIImage imageNamed:@"user_Center_Day.png"]];
    
    CBNBarBurronItem *rightBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(rightBar:) andFrame:CGRectMake(0, 0, 30, 30) andImage:[UIImage imageNamed:@"book_Shop_Day.png"]];
    
    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.navigationItem.rightBarButtonItem= rightBar;
    
    
}
-(void)leftBar:(id)sender{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}
-(void)rightBar:(id)sender{
    CBNSetterVC *setterVC = [[CBNSetterVC alloc] init];
    
    [self.navigationController pushViewController:setterVC animated:YES];
    
    
}
- (UITableView *)aTableView {
    if (_aTableView == nil) {
        _aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        _aTableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xFFFFFF,0x363636,0xFFFFFF);
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _aTableView;
}

-(void)setupTableView {
    
    [self.view addSubview:self.aTableView];
    
//    [_aScrollView addSubview:self.aTableView];
    _aTableView.tableHeaderView = self.headerView;
    
    
    
}
#pragma mark -  UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.segmentView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return segmentView_Height;
}
#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"11%@11",self.sourceArray);
    return self.sourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row == 0) {
        static NSString *identifier = @"CBNProjectArrayCell";
        
        
        CBNProjectArrayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[CBNProjectArrayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        return cell;

    }
    CBNChannelNewsModel *channelModel = [_sourceArray objectAtIndex:indexPath.row];
    
    if (indexPath.row%5==0) {
        
        static NSString *identifier = @"CBNVideoNewsCell";
        
        
        CBNVideoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[CBNVideoNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.channelNewsModel = channelModel;
        return cell;
    }
    
    if (indexPath.row%3==0) {
        
        static NSString *identifier = @"CBNRecommendNewsCell";
        
        
        CBNRecommendNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[CBNRecommendNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.channelNewsModel = channelModel;

        return cell;
    }
    
    static NSString *identifier = @"CBNNormalNewsCell";
    
    
    CBNNormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[CBNNormalNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.channelNewsModel = channelModel;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        CBNProjectArrayCell *cell = (CBNProjectArrayCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }
    if (indexPath.row%5==0) {
        
        CBNVideoNewsCell *cell = (CBNVideoNewsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
    }
    
    if (indexPath.row%3==0) {
        CBNRecommendNewsCell *cell = (CBNRecommendNewsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    CBNNormalNewsCell *cell = (CBNNormalNewsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNTextArticleDetailVC *ar = [[CBNTextArticleDetailVC alloc] init];
    
    [self.navigationController pushViewController:ar animated:YES];

}
#pragma mark -  重点的地方在这里 滚动时候进行计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<-64) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }
    CGFloat alpha = offsetY / navigation_Show;
    
    if (offsetY> navigation_Show -64) {
        [UIView animateWithDuration:0.5 animations:^{
            self.headerView.sliderView.maskImageView.backgroundColor = RGBColor(0.0, 0.0, 1.2, alpha);
        }];
        self.navigationView.hidden = NO;

        
    }else if (offsetY >=-64 && offsetY <= navigation_Show-64){
        
        [UIView animateWithDuration:0.5 animations:^{
            self.headerView.sliderView.maskImageView.backgroundColor = RGBColor(0.0, 0.0, 0.0, alpha*1.2);
        }];

        self.navigationView.hidden = YES;
        
    }else{
   
        self.navigationView.hidden = YES;
        
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [UIView animateWithDuration:1 animations:^{
//        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
//        [UIView animateWithDuration:5 animations:^{
//            self.navigationController.navigationBar.alpha = 0;
//        }];
//    }];
//    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}
#define mark 控件的创建
- (CBNRecommendHeaderView *)headerView
{
    if (!_headerView) {
        
        self.headerView = [[CBNRecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, navigation_Show )];
        
    }
    
    return _headerView;
}
- (CBNSegmentView *)segmentView
{
    if (!_segmentView) {
        
        NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:[[CBNFileManager sharedInstance] loadPlistFilePathWithPlistName:@"CBNChannel"]];
        
        NSMutableArray *resultArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *channelInfo in arr) {
            
            CBNSegmentModel *segmentiItem = [[CBNSegmentModel alloc] init];
            
            segmentiItem.title = [channelInfo objectForKey:@"title"];
            
            segmentiItem.channelID = [channelInfo objectForKey:@"ChannelID"];
            
            [resultArr addObject:segmentiItem];

        }
        _segmentView = [[CBNSegmentView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, segmentView_Height) andTitleItemArray:resultArr];
        __weak typeof(self) weakSelf = self;
        
        _segmentView.channelChanged = ^(CBNSegmentModel *channelItem){
            
            [weakSelf channelChanged:channelItem];
            
        };
    }
    return _segmentView;
}
- (void)channelChanged:(CBNSegmentModel *)channelItem
{
    if (channelItem.channelID!=0) {
        self.channelItem = channelItem;
        [self refreshChannelSource];
    }
}
- (UIView *)navigationView
{
    if (!_navigationView) {
        
        self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 64)];
        
        _navigationView.backgroundColor = RGBColor(0.0, 0.0, 0.0, 1);
        
        self.navigationView.hidden = YES;
        
    }
    
    return _navigationView;
}

@end
