//
//  CBNTextArticleDetailVC.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNTextArticleDetailVC.h"
#import "CBNArticleHeaderNoImageView.h"
#import "CBNChaptInfoModel.h"
#import "CBNChaptAuthorModel.h"
#import "CBNArticleModel.h"
#import "CBNChaptBlockCell.h"
#import "CBNChaptBlockModel.h"
#import "CBNChaptSubTitleCell.h"
#import "CBNChaptImageCell.h"
#import "CBNADWebVC.h"
#import "CBNArticleHeaderNormalView.h"
#import "CBNDetailBottomView.h"

@interface CBNTextArticleDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    CBNArticleHeaderNormalView *headerView;
}
@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) CBNArticleModel *articleModel;

@property (nonatomic, strong) CBNDetailBottomView *bottomView;

@property (nonatomic, strong) UITextView *cmment;
@end

@implementation CBNTextArticleDetailVC


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.translucent=YES;
    self.navigationController.navigationBar.hidden = YES;

}

- (void)dealloc
{
    NSLog(@"释放");
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent=NO;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x656782) andFrame:CGRectMake(0, 0, screen_Width, 64)]forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.backgroundColor = UIColorFromRGB(0x656782);

    [self setNavigationHeader];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.aTableView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [[NSBundle mainBundle] pathForResource:@"21860" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:str];
        
        NSDictionary *newDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        self.articleModel = [[CBNArticleModel alloc] initArticleResult:newDic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",_articleModel.block_list);
            
            [_aTableView reloadData];
            
        });
        
    });
    
    
    
    headerView = [[CBNArticleHeaderNormalView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    
    __weak typeof(self) weakSelf = self;
    
    
    
    CBNChaptInfoModel *chaptInfo = [[CBNChaptInfoModel alloc] init];
    
    chaptInfo.chaptTitle = @"愤怒的小鸟领路，切水果和俄罗斯方块也在冲向大银幕";
    chaptInfo.chaptBrief = @"如今IP当道，全世界能做IP的东西几乎都在考虑要不要做成电影，或者正被做成电影，或是已经路上了.......";
    headerView.chapt_Info_Model = chaptInfo;
    NSArray *sourceArray = @[@{@"width":@"300",
                               @"fontSize":[NSNumber numberWithInt:fontSize(36.0,36.0,36.0)],
                               @"textColor":[NSNumber numberWithInt:0x515151],
                               @"modleType":[NSNumber numberWithInt:JHCoreTextModleTextType]
                               ,@"text":@"作者："},
                             @{@"width":@"200",
                               @"fontSize":[NSNumber numberWithInt:fontSize(36.0,36.0,36.0)],
                               @"textColor":[NSNumber numberWithInt:0x515151],
                               @"modleType":[NSNumber numberWithInt:JHCoreTextModleButtonType]
                               ,@"text":@" 习近平 "},
                             @{@"width":@"200",
                               @"fontSize":[NSNumber numberWithInt:fontSize(36.0,36.0,36.0)],
                               @"textColor":[NSNumber numberWithInt:0x515151],
                               @"modleType":[NSNumber numberWithInt:JHCoreTextModleButtonType]
                               ,@"text":@"|"},
                             @{@"width":@"200",
                               @"fontSize":[NSNumber numberWithInt:fontSize(36.0,36.0,36.0)],
                               @"textColor":[NSNumber numberWithInt:0x515151],
                               @"modleType":[NSNumber numberWithInt:JHCoreTextModleButtonType]
                               ,@"text":@" 李克强 "},
                             @{@"width":@"200",
                               @"fontSize":[NSNumber numberWithInt:fontSize(36.0,36.0,36.0)],
                               @"textColor":[NSNumber numberWithInt:0x515151],
                               @"modleType":[NSNumber numberWithInt:JHCoreTextModleButtonType]
                               ,@"text":@"|"},
                             @{@"width":@"200",
                               @"fontSize":[NSNumber numberWithInt:fontSize(36.0,36.0,36.0)],
                               @"textColor":[NSNumber numberWithInt:0x515151],
                               @"modleType":[NSNumber numberWithInt:JHCoreTextModleButtonType]
                               ,@"text":@" 张德江 "},
                             @{@"width":@"200",
                               @"fontSize":[NSNumber numberWithInt:fontSize(36.0,36.0,36.0)],
                               @"textColor":[NSNumber numberWithInt:0x515151],
                               @"modleType":[NSNumber numberWithInt:JHCoreTextModleTextType]
                               ,@"text":@""}];
    headerView.author_List = sourceArray;
    
    headerView.authorLabel.labelClicked = ^(JHCoreTextModle *sender){
        
        
        CBNADWebVC *webVC = [[CBNADWebVC alloc] init];
        
        if ([sender.text isEqualToString:@" 习近平 "]) {
            webVC.webURL = @"http://baike.baidu.com/link?url=_CTyoZynXejuQg-5nsZZahx7jKiCPGyJ4RZxVMFNZkMSWZk4AOEecWcEU1YCA4BFHhOoxxShss8By_i-Nc9Woa";
            
        }else if ([sender.text isEqualToString:@" 李克强 "]){
            webVC.webURL = @"http://baike.baidu.com/link?url=jrWhZuXMDu1XH_8GFWiBZ5c2D7xEWGyPgmmiOpGmPZqZ8cK5HEZxnJ0oL0ZZz11vv4zsk_0sdfE5QGjToRwSsbVsoviCbnMba3Wd-ttwwn7";
            
        }else if ([sender.text isEqualToString:@" 张德江 "])
        {
            webVC.webURL = @"http://baike.baidu.com/link?url=gyiupluQUdERFtywGrH21PkK_HGR3LUFrkitTMFMj0cVby7ySW15GOa0Qd-aXK-4bWGkWRvJT4jAV3aCgPabISDnTt14XqFzsf78C-HMVtO";
            
        }
        
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    };
    _aTableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.cmment];

}
- (CBNDetailBottomView *)bottomView
{
    if (!_bottomView) {
        
        self.bottomView = [[CBNDetailBottomView alloc] initWithFrame:CGRectMake(0, screen_Height - 44, screen_Height, 44)];
        __weak typeof(self) weakSelf = self;
        
        _bottomView.aaaaaa = ^(NSDictionary *keyWordInfo){
            NSLog(@"%@",weakSelf.bottomView);
            [weakSelf.cmment becomeFirstResponder];
            weakSelf.cmment.hidden = NO;

//            weakSelf.cmment.frame = CGRectMake(0, screen_Height-400, screen_Width, 200);
        };
        
    }
    
    return _bottomView;
}
- (UITextView *)cmment
{
    if (!_cmment) {
        
        self.cmment = [[UITextView alloc] initWithFrame:CGRectMake(0, screen_Height-200 , screen_Width, 200)];
        
        _cmment.backgroundColor = [UIColor redColor];
        
        _cmment.hidden = YES;
        
        
    }
    
    return _cmment;
}
/*
 *  设置NavigationHeaderBar
 */
- (void)setNavigationHeader
{
    CBNBarBurronItem *leftBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(leftBar:) andFrame:CGRectMake(0, 0, 30, 30) andImage:[UIImage imageNamed:@"userCenter_Day_Image@2x.png"]];
    
    CBNBarBurronItem *nightBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(nightBar:) andFrame:CGRectMake(0, 0, 44, 44) andImagePicker:DKImagePickerWithImages([UIImage imageWithColor:RGBColor(245, 245,245, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(3, 3,3, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(3, 3,3, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)])];
    CBNBarBurronItem *fontBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(fontBar:) andFrame:CGRectMake(0, 0, 44, 44) andImagePicker:DKImagePickerWithImages([UIImage imageWithColor:RGBColor(245, 245,245, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(3, 3,3, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(3, 3,3, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)])];

    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.navigationItem.rightBarButtonItems= [NSArray arrayWithObjects:nightBar,fontBar, nil];
    
    
}
- (void)leftBar:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)nightBar:(id)sender
{
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        
        [self.dk_manager dawnComing];
        
    } else {
        
        [self.dk_manager nightFalling];
        
    }

}
- (void)fontBar:(id)sender
{
    
}
#pragma mark 创建tableView
- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.dk_backgroundColorPicker =  DKColorPickerWithKey(默认背景颜色);
    }
    
    return _aTableView;
}

#pragma mark tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"?? %ld",self.articleModel.block_list.count);
    return self.articleModel.block_list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CBNChaptBlockModel *chaptBlockModel = [_articleModel.block_list objectAtIndex:indexPath.row];
    
    
    if ([chaptBlockModel.blockType isEqualToString:@"text"]) {
        
        static NSString *identifier = @"ChaptBlockCell";
        
        CBNChaptBlockCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSLog(@"创建 %ld",indexPath.row);
            cell = [[CBNChaptBlockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            __weak typeof(self) weakSelf = self;
            
            [cell.blockTextView CBNChaptKeyWordClicked:^(NSDictionary *keyWordInfo) {
                [weakSelf keyWordClicked:keyWordInfo];
                
            } copyAction:^(NSDictionary *copyInfo) {
                
            } readPressedAction:^(NSDictionary *readPressedInfo) {
                
            } cancleReadPressedAction:^(NSDictionary *cancleReadPressedInfo) {
                
            }];
        }
        cell.chaptBlockModel = chaptBlockModel;
        
        chaptBlockModel = cell.chaptBlockModel;
        
        [_articleModel.block_list replaceObjectAtIndex:indexPath.row withObject:chaptBlockModel];
        
        [cell setNeedsDisplay];
        
        return cell;
        
    }else if ([chaptBlockModel.blockType isEqualToString:@"subtitle"]){
        static NSString *identifier = @"CBNChaptSubTitleCell";
        
        
        CBNChaptSubTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSLog(@"创建 %ld",indexPath.row);
            cell = [[CBNChaptSubTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            __weak typeof(self) weakSelf = self;
            
            [cell.blockTextView CBNChaptKeyWordClicked:^(NSDictionary *keyWordInfo) {
                [weakSelf keyWordClicked:keyWordInfo];
                
            } copyAction:^(NSDictionary *copyInfo) {
                
            } readPressedAction:^(NSDictionary *readPressedInfo) {
                
            } cancleReadPressedAction:^(NSDictionary *cancleReadPressedInfo) {
                
            }];
            
        }
        
        cell.chaptBlockModel = chaptBlockModel;
        
        chaptBlockModel = cell.chaptBlockModel;
        [_articleModel.block_list replaceObjectAtIndex:indexPath.row withObject:chaptBlockModel];
        
        return cell;
    }else{
        static NSString *identifier = @"CBNChaptImageCell";
        
        
        CBNChaptImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSLog(@"走起 %ld",(long)indexPath.row);
            cell = [[CBNChaptImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        
        cell.chaptBlockModel = chaptBlockModel;
        
        chaptBlockModel = cell.chaptBlockModel ;
        [_articleModel.block_list replaceObjectAtIndex:indexPath.row withObject:chaptBlockModel];
        
        return cell;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CBNChaptBlockModel *chaptBlockModel = [_articleModel.block_list objectAtIndex:indexPath.row];
    
    if (chaptBlockModel.height == 0.0) {
        
        return 1000;
        
    }
    return chaptBlockModel.height;
    
    
}
- (void)keyWordClicked:(NSDictionary *)sender
{
    NSLog(@"%@",sender);
    CBNADWebVC *webVC = [[CBNADWebVC alloc] init];
    
    webVC.webURL = [[sender objectForKey:@"keyWordContent"] description];
    
    [self.navigationController pushViewController:webVC animated:YES];
    //
    //    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:[[sender objectForKey:@"keyWordContent"] description] message:[sender objectForKey:@"keyWordType"] delegate:sender cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    //    [alter show];
}


@end
