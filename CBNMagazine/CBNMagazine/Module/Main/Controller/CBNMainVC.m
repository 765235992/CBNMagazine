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
#import "CBNWebDetailVC.h"

#import "CBNSetterVC.h"
#import "CBNTextArticleDetailVC.h"

#define navigation_Show  (float)(0.73*screen_Width -64)


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
@property (nonatomic, strong) NSMutableArray *sliderArray;
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
- (id)init
{
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:@"HLChannelRootVC"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
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


    [self refreshSliderDadaFromSever];
    
}

- (void)refreshSliderDadaFromSever
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",sever_URL,Index,@"SWF"];
    
    NSString *secretStr = [NSString getTheMD5EncryptedStringWithString:[NSString stringWithFormat:@"%@%@",secret_key,@"SWF"]];
    
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    [parDic setObject:secretStr forKey:sever_key_Str];
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelRequest GET:urlString parameters:parDic success:^(id result) {
        
        if ([[result objectForKey:@"Code"]integerValue] == 200) {
            
            NSLog(@"%@",result);
            NSInteger count = 0;
            [self.sliderArray removeAllObjects];
            NSMutableArray *arr1 = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in [[result objectForKey:@"DataList"] objectForKey:@"data"]) {
                
                NSInteger dataType = [[dic objectForKey:@"DataType"] integerValue];
                
                
                CBNChannelNewsModel *channelModel = [[CBNChannelNewsModel alloc]initWithChannelNewsInfo:dic andType:dataType];
                
                CBNShufflingModel *itemModel = [[CBNShufflingModel alloc] init];
                
                itemModel.newsThumbStr = channelModel.cover_img_big;
                
                itemModel.newsTitleStr = channelModel.chapt_title;
                
                itemModel.newsDefaultImage = [UIImage imageNamed:@"defaultImage.jpg"];
                
                itemModel.index = count;
                count++;
                
                
                [arr1 addObject:itemModel];

                [_sliderArray addObject:channelModel];
            }

            weakSelf.headerView.sliderView.shufflingView.sourceModelArray = arr1;
        }
 
    } failed:^(NSError *error) {
       
    }];
    

}


/*
 *  网络请求数据刷新动作
 */
- (void)refreshChannelSource
{
    [self.sourceArray removeAllObjects];
    
    [self.aTableView reloadData];
    
    _recommendCount = 0;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",sever_URL,Index,@"GetIndexArticleList"];
    
    NSString *secretStr = [NSString getTheMD5EncryptedStringWithString:[NSString stringWithFormat:@"%@%@",secret_key,@"GetIndexArticleList"]];
    
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    [parDic setObject:secretStr forKey:sever_key_Str];

    [CBNChannelRequest GET:urlString parameters:parDic success:^(id result) {
        NSLog(@"%@",result);
        if ([[result objectForKey:@"Code"]integerValue] == 200) {
            CBNChannelNewsModel *projectModel = [[CBNChannelNewsModel alloc]initWithChannelNewsInfo:nil andType:999];
            [_sourceArray addObject:projectModel];

            for (NSDictionary *dic in [[result objectForKey:@"DataList"] objectForKey:@"data"]) {
                
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

        }
        [_aTableView reloadData];
        [_aTableView.mj_header endRefreshing];
    } failed:^(NSError *error) {
        [_aTableView reloadData];
        [_aTableView.mj_header endRefreshing];
    }];
    
 
}

- (void)loadMoreChannelDataFromSever
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",sever_URL,Index,@"GetIndexArticleList"];
    
    NSString *secretStr = [NSString getTheMD5EncryptedStringWithString:[NSString stringWithFormat:@"%@%@",secret_key,@"GetIndexArticleList"]];
    
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    [parDic setObject:secretStr forKey:sever_key_Str];
    
    [CBNChannelRequest GET:urlString parameters:parDic success:^(id result) {
        
        if ([[result objectForKey:@"Code"]integerValue] == 200) {
            
//            NSLog(@"")
            for (NSDictionary *dic in [[result objectForKey:@"DataList"] objectForKey:@"data"]) {
                
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
            
        }
        [_aTableView reloadData];
        [_aTableView.mj_footer endRefreshing];
    } failed:^(NSError *error) {
        [_aTableView reloadData];
        [_aTableView.mj_footer endRefreshing];
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
    
    
    // 马上进入刷新状态
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshChannelSource)];
    
    // 设置文字
    [header setTitle:@"下拉开始刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"正在刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载中......" forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = font_px_Medium(fontSize(36.0,36.0,36.0));;
    header.lastUpdatedTimeLabel.font = font_px_Medium(fontSize(32.0,32.0,32.0));;
    // 设置颜色
    header.stateLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
    header.lastUpdatedTimeLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
    // 设置刷新控件
    self.aTableView.mj_header = header;
    [_aTableView.mj_header beginRefreshing];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreChannelDataFromSever)];
    [footer setTitle:@" " forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    // 设置字体
    footer.stateLabel.font = font_px_Medium(fontSize(32.0,32.0,32.0));;
    // 设置颜色
    footer.stateLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
    
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
    NSLog(@"chaptID %@  issueID %@",channelModel.chatp_id,channelModel.issue_id);
    
    if ([channelModel.data_type integerValue] == 999) {
        static NSString *identifier = @"CBNProjectArrayCell";
        
        CBNProjectArrayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        __weak typeof(self) weakSelf = self;
        
        if (cell == nil) {
            CBNLog(@"创建");
            
            cell = [[CBNProjectArrayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            cell.projectCollectionView.projectCellClicked = ^(NSIndexPath *indexPath, CBNProjectModel *projectModel)
            {
                
                [weakSelf projectClicked:projectModel];
                
            };
        }
        cell.channelNewsModel = channelModel;
        
        channelModel = cell.channelNewsModel ;
        [_sourceArray replaceObjectAtIndex:indexPath.row withObject:channelModel];
        return cell;

    }else if ([channelModel.data_type integerValue] == 3) {
        static NSString *identifier = @"CBNAudioNewsCell";
        
        
        CBNAudioNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            CBNLog(@"创建");

            cell = [[CBNAudioNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.channelNewsModel = channelModel;
        return cell;
    }else if ([channelModel.data_type integerValue] == 2){
        static NSString *identifier = @"CBNVideoNewsCell";
        
        
        CBNVideoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            CBNLog(@"创建");

            cell = [[CBNVideoNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.channelNewsModel = channelModel;
        return cell;

    }else if ([channelModel.data_type integerValue] == 1){
        static NSString *identifier = @"CBNRecommendNewsCell";
        
        
        CBNRecommendNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            CBNLog(@"创建");

            cell = [[CBNRecommendNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.channelNewsModel = channelModel;
        
        return cell;
    }else{
        static NSString *identifier = @"CBNNormalNewsCell";
        
        
        CBNNormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            CBNLog(@"创建");

            cell = [[CBNNormalNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.channelNewsModel = channelModel;
        
        channelModel = cell.channelNewsModel ;

        [_sourceArray replaceObjectAtIndex:indexPath.row withObject:channelModel];
        
        return cell;

    }

    
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
    
    CBNChannelNewsModel *channelModel = [_sourceArray objectAtIndex:indexPath.row];

    CBNTextArticleDetailVC *ar = [[CBNTextArticleDetailVC alloc] init];
    
    ar.chapt_ID = channelModel.chatp_id;
    
    ar.issue_ID = channelModel.issue_id;
    
    [self.navigationController pushViewController:ar animated:YES];
    
}
- (void)projectClicked:(CBNProjectModel *)projectModel
{
    CBNWebDetailVC *webDetaileVC = [[CBNWebDetailVC alloc] init];
    
    webDetaileVC.webURL = projectModel.url;
    
    [self.navigationController pushViewController:webDetaileVC animated:YES];
    NSLog(@"%@",projectModel.url);
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

- (void)sliderToDetailWithShufflingModel:(CBNShufflingModel *)shufflingModel
{
    
    CBNChannelNewsModel *channelModel = [_sliderArray objectAtIndex:shufflingModel.index];

    CBNTextArticleDetailVC *ar = [[CBNTextArticleDetailVC alloc] init];
    
    ar.chapt_ID = channelModel.chatp_id;
    
    ar.issue_ID = channelModel.issue_id;
    
    [self.navigationController pushViewController:ar animated:YES];
}
#define mark 控件的创建
- (CBNRecommendHeaderView *)headerView
{
    if (!_headerView) {
        
        self.headerView = [[CBNRecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, navigation_Show )];
        __weak typeof(self) weakSelf = self;

        _headerView.sliderView.shufflingView.imageViewDidTapAtIndex = ^(CBNShufflingModel *shufflingModel){
            
            [weakSelf sliderToDetailWithShufflingModel:shufflingModel];
            
        };
        
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
- (NSMutableArray *)sliderArray

{
    if (!_sliderArray) {
        
        self.sliderArray = [[NSMutableArray alloc] init];
    }
    
    return _sliderArray;
}
@end
