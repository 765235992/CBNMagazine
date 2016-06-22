//
//  CBNMainVC.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNMainVC.h"
#import "MMDrawerBarButtonItem.h"
#import "CBNSegmentView.h"
#import "CBNSegmentModel.h"
#import "CBNChannelNetwork.h"
#import "CBNChannelNewsModel.h"
#import "UIColor+Extension.h"

#import "CBNRecommendHeaderView.h"
#import "CBNNavigationHeaderView.h"

/*
 *  新闻五种定制类型
 */
#import "CBNAudioNewsCell.h"
#import "CBNVideoNewsCell.h"
#import "CBNNormalNewsCell.h"
#import "CBNProjectArrayCell.h"
#import "CBNRecommendNewsCell.h"
#import "MJRefresh.h"

/*
 *  可以push的控制器
 */
#import "CBNSetterVC.h"
#import "CBNTextArticleDetailVC.h"

#define navigation_Show  (float)(0.73*screen_Width -64)

static const CGFloat MJDuration = 1.0;

@interface CBNMainVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) CBNNavigationHeaderView *navigationView;
@property (nonatomic, strong) UITableView *aTableView;
@property (nonatomic, strong) CBNRecommendHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *segmentArray;
@property (nonatomic, strong) CBNSegmentModel *channelItem;
@property (nonatomic, strong) CBNSegmentView *segmentView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) CBNChannelNetwork *channelNetworkRequest;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger recommendCount;

@end

@implementation CBNMainVC
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor clearColor] imageWithColor] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     *  设置NavigationHeaderBar
     */
    [self setNavigationHeader];
    
    /*
     *  设置开机默认频道
     */
    [self setDefaultChannel];
    
    /*
     *  添加列表
     */
    [self setupTableView];
    
    /*
     *  添加底片
     */
    [self.view addSubview:self.navigationView];
    

    
}


/*
 *  从coreData中取出数据
 */
- (void)loadDataFromCoreData
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [[NSBundle mainBundle] pathForResource:@"newsList" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:str];
        
        NSDictionary *newDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",newDic);
        for (NSDictionary *dic in [newDic objectForKey:@"DataList"]) {
            NSLog(@"%@",dic);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [_aTableView reloadData];
            [_aTableView.mj_header endRefreshing];
        });
        
    });


    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        // 刷新表格
//        [_aTableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [_aTableView.mj_header endRefreshing];
//    });
//    
}

/*
 *  网络请求数据刷新动作
 */
- (void)refreshChannelSource
{
    
    
    
   
    [self.sourceArray removeAllObjects];
    [self.aTableView reloadData];
    
    _recommendCount = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [[NSBundle mainBundle] pathForResource:@"newsList" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:str];
        
        NSDictionary *newDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",newDic);
        NSLog(@"%@",newDic);

        for (NSDictionary *dic in [[newDic objectForKey:@"DataList"] objectForKey:@"data"]) {

            NSInteger dataType = [[dic objectForKey:@"DataType"] integerValue];
            
            if (dataType == 1) {
                /*
                 *  视频
                 */
                if (_recommendCount != 3) {
                    dataType = 0;
                    _recommendCount++;
                }else{
                    dataType = 1;
                    _recommendCount = 0;
                }
            }
            
            CBNChannelNewsModel *channelModel = [[CBNChannelNewsModel alloc]initWithChannelNewsInfo:dic andType:dataType];
            
            [_sourceArray addObject:channelModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [_aTableView reloadData];
            [_aTableView.mj_header endRefreshing];
        });
        
    });

    // 拿到当前的下拉刷新控件，结束刷新状态

    
    
    
//    [self.channelNetworkRequest cannelRequest];
//    __weak typeof(self) wekSelf = self;
//    [self.channelNetworkRequest loadChannelInfoWithChannelID:self.channelItem.channelID secuessed:^(id result) {
//        if ([self.channelItem.channelID isEqualToString:@"13"]) {
//            
//            
//            NSDictionary *dic = @{@"customType":@"customType"};
//            CBNChannelNewsModel *channelModel = [[CBNChannelNewsModel alloc]initWithChannelNewsInfo:dic];
//            [wekSelf.sourceArray addObject:channelModel];
//
//        }
//        for (int i = 0; i < [[result objectForKey:@"article_list"] count]; i++) {
//            
//            NSDictionary *channelInfo = [[result objectForKey:@"article_list"] objectAtIndex:i];
//            
//            CBNChannelNewsModel *channelModel = [[CBNChannelNewsModel alloc]initWithChannelNewsInfo:channelInfo];
//            
//            [wekSelf.sourceArray addObject:channelModel];
//        }
//        // 刷新表格
//        [wekSelf.aTableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [wekSelf.aTableView.mj_header endRefreshing];
//        
//        
//    } failed:^(id error) {
//        // 刷新表格
//        [wekSelf.aTableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//        [wekSelf.aTableView.mj_header endRefreshing];
//        
//    }];
    
}

- (void)footerRereshing
{
    NSString *str = [[NSBundle mainBundle] pathForResource:@"newsList" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:str];
    
    NSDictionary *newDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@",newDic);
    
    for (NSDictionary *dic in [[newDic objectForKey:@"DataList"] objectForKey:@"data"]) {
        
        NSInteger dataType = [[dic objectForKey:@"DataType"] integerValue];
        
        if (dataType == 1) {
            /*
             *  视频
             */
            if (_recommendCount != 3) {
                dataType = 0;
                _recommendCount++;
            }else{
                dataType = 1;
                _recommendCount = 0;
            }
        }
        
        CBNChannelNewsModel *channelModel = [[CBNChannelNewsModel alloc]initWithChannelNewsInfo:dic andType:dataType];
        
        [_sourceArray addObject:channelModel];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_aTableView reloadData];
        
        [self.aTableView.mj_footer endRefreshing];
    });
    
    
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
    CBNBarBurronItem *leftBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(leftBar:) andFrame:CGRectMake(0, 0, 44, 44) andImage:[RGBColor(0, 0, 0, 1) colorImage]];
    
    CBNBarBurronItem *rightBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(rightBar:) andFrame:CGRectMake(0, 0, 44, 44) andImage:[RGBColor(0, 0, 0, 0) colorImage]];
    
    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.navigationItem.rightBarButtonItem= rightBar;
    
}
/*
 *  抽屉打开
 */
-(void)leftBar:(id)sender
{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}
/*
 *  前往设置
 */
-(void)rightBar:(id)sender
{
    CBNSetterVC *setterVC = [[CBNSetterVC alloc] init];
    
    [self.navigationController pushViewController:setterVC animated:YES];
    
    
}
/*
 *  初始化列表
 */
- (UITableView *)aTableView
{
    if (_aTableView == nil) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
        
        _aTableView.dk_backgroundColorPicker = DKColorPickerWithKey(默认背景颜色);
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _aTableView;
}

-(void)setupTableView
{
    
    [self.view addSubview:self.aTableView];
    
    _aTableView.tableHeaderView = self.headerView;
    
    _aTableView.mj_header = [CBNRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshChannelSource)];
    
    // 马上进入刷新状态
    [_aTableView.mj_header beginRefreshing];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    // 设置文字
    [footer setTitle:@" " forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor orangeColor];
    
    // 设置footer
    self.aTableView.mj_footer = footer;
    
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
    return self.sourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CBNChannelNewsModel *channelModel = [_sourceArray objectAtIndex:indexPath.row];
    
    if ([channelModel.data_type integerValue] == 3) {
        static NSString *identifier = @"CBNAudioNewsCell";
        
        
        CBNAudioNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[CBNAudioNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.channelNewsModel = channelModel;
        return cell;
    }else if ([channelModel.data_type integerValue] == 2){
        static NSString *identifier = @"CBNVideoNewsCell";
        
        
        CBNVideoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[CBNVideoNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.channelNewsModel = channelModel;
        return cell;

    }else if ([channelModel.data_type integerValue] == 1){
        static NSString *identifier = @"CBNRecommendNewsCell";
        
        
        CBNRecommendNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[CBNRecommendNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.channelNewsModel = channelModel;
        
        return cell;
    }else{
        static NSString *identifier = @"CBNNormalNewsCell";
        
        
        CBNNormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[CBNNormalNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.channelNewsModel = channelModel;
        
        channelModel = cell.channelNewsModel ;
        NSLog(@"%@",channelModel);
        [_sourceArray replaceObjectAtIndex:indexPath.row withObject:channelModel];
        return cell;

    }
//    if ([channelModel.custom_type isEqualToString:@"customType"]) {
//        static NSString *identifier = @"CBNProjectArrayCell";
//        
//        
//        CBNProjectArrayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        
//        if (cell == nil) {
//            
//            cell = [[CBNProjectArrayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        }
//        
//        return cell;
//        
//    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CBNChannelNewsModel *channelModel = [_sourceArray objectAtIndex:indexPath.row];

    if (channelModel.height == 0.0 ) {
        return 100;
    }
    return channelModel.height;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNTextArticleDetailVC *ar = [[CBNTextArticleDetailVC alloc] init];
    
    [self.navigationController pushViewController:ar animated:YES];
    
}
#pragma mark -  重点的地方在这里 滚动时候进行计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY<-64) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        _navigationView.hidden = YES;
        
    }else{
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        _navigationView.hidden = NO;

    }
    
    CGFloat alpha = offsetY / (navigation_Show-64);
    
    if (offsetY> navigation_Show -64) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.headerView.sliderView.maskImageView.backgroundColor = RGBColor(0.0, 0.0, 0.0, alpha);
            
        }];
        _navigationView.backgroundColor = RGBColor(0.0, 0.0, 0.0, 1);

        
    }else if (offsetY >=-64 && offsetY <= navigation_Show-64){
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.headerView.sliderView.maskImageView.backgroundColor = RGBColor(0.0, 0.0, 0.0, alpha);

        }];
        _navigationView.backgroundColor = RGBColor(0.0, 0.0, 0.0, 0);

        
    }
}


#define mark 控件的创建
- (CBNRecommendHeaderView *)headerView
{
    if (!_headerView) {
        
        self.headerView = [[CBNRecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, navigation_Show )];
        
    }
    
    return _headerView;
}


- (NSMutableArray *)segmentArray
{
    if (!_segmentArray) {
        self.segmentArray = [[NSMutableArray alloc] init];
        
        NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:[[CBNFileManager sharedInstance] loadPlistFilePathWithPlistName:@"CBNChannel"]];
        
        for (NSDictionary *channelInfo in arr) {
            
            CBNSegmentModel *segmentItem = [[CBNSegmentModel alloc] init];
            
            segmentItem.title = [channelInfo objectForKey:@"title"];
            
            segmentItem.channelID = [channelInfo objectForKey:@"ChannelID"];
            
            segmentItem.index = [[channelInfo objectForKey:@"index"] integerValue];
            
            [_segmentArray addObject:segmentItem];
            
        }
        
    }
    
    return _segmentArray;
}
/*
 *  初始化频道列表
 */
- (CBNSegmentView *)segmentView
{
    if (!_segmentView) {
        
        self.segmentView = [[CBNSegmentView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, segmentView_Height) andTitleItemArray:self.segmentArray];
        __weak typeof(self) weakSelf = self;
        
        _segmentView.channelChanged = ^(CBNSegmentModel *channelItem){
            
            [weakSelf channelChanged:channelItem];
            
        };
    }
    return _segmentView;
}
/*
 *  频道切换
 */
- (void)channelChanged:(CBNSegmentModel *)channelItem
{
    self.channelItem = channelItem;
    [self refreshChannelSource];
}
/*
 *  设置开机默认频道
 */
- (void)setDefaultChannel
{
    self.channelItem = [self.segmentArray objectAtIndex:0];
}
/*
 *  添加底片
 */
- (CBNNavigationHeaderView *)navigationView
{
    if (!_navigationView) {
        
        self.navigationView = [[CBNNavigationHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 64)];
        
        _navigationView.backgroundColor = RGBColor(0.0, 0.0, 0.0, 0.0);

        
    }
    
    return _navigationView;
}
- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
    }
    
    return _sourceArray;
}
@end
