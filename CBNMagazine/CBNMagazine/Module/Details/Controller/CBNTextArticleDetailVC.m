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
#import "CBNCommentsEditorView.h"
#import "UIColor+Extension.h"
#import "CBNArticleRequest.h"

@interface CBNTextArticleDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (nonatomic, strong) CBNArticleHeaderNormalView *headerView;
@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) CBNArticleModel *articleModel;

@property (nonatomic, strong) CBNDetailBottomView *bottomView;

@property (nonatomic, strong) CBNCommentsEditorView *commentsEditorView;
@end

@implementation CBNTextArticleDetailVC



- (void)dealloc
{
    NSLog(@"释放");
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@--%@",self.chapt_ID,self.issue_ID);
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setNavigationHeader];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.aTableView];
    
    NSString *secretStr = [NSString getTheMD5EncryptedStringWithString:[NSString stringWithFormat:@"%@%@",secret_key,@"index"]];
    
    NSString *secretStr2 = [NSString getTheMD5EncryptedStringWithString:[NSString stringWithFormat:@"%@%@%@",self.chapt_ID,self.issue_ID,secret_key]];
    
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    [parDic setObject:secretStr forKey:@"key"];
    [parDic setObject:secretStr2 forKey:@"setKey"];
    [parDic setObject:self.chapt_ID forKey:@"chapt_id"];
    [parDic setObject:self.issue_ID forKey:@"issue_id"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",sever_URL,Daymore,@"index"];

    [CBNArticleRequest GET:urlString parameters:parDic success:^(id result) {
        
        NSLog(@"%@",[result objectForKey:@"Error"]);
        
        if ([[result objectForKey:@"Code"] integerValue] == 200) {
            self.articleModel = [[CBNArticleModel alloc] initArticleResult:[result objectForKey:@"DataList"]];
            
            self.headerView.chapt_Info_Model = _articleModel.chapt_info;
            
            _headerView.author_List = _articleModel.author_list;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_aTableView setTableHeaderView:self.headerView];
                
                [_aTableView reloadData];
                
            });

        }else{
            
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[result objectForKey:@"Error"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            
            [alter show];
            
        }
        
    
    } failed:^(NSError *error) {
        NSLog(@"%@  ",error);

    }];



    

 


}
- (CBNArticleHeaderNormalView *)headerView
{
    if (!_headerView) {
        self.headerView = [[CBNArticleHeaderNormalView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
        __weak typeof(self) weakSelf = self;

        _headerView.authorLabel.labelClicked = ^(JHCoreTextModle *sender){
            
            [weakSelf headerViewClicked];
            
        };
    }
    
    return _headerView;
}
- (void)headerViewClicked
{
    NSLog(@"daskhdjh");
}
- (CBNDetailBottomView *)bottomView
{
    if (!_bottomView) {
        
        self.bottomView = [[CBNDetailBottomView alloc] initWithFrame:CGRectMake(0, screen_Height - 64 - 44, screen_Height, 44)];
        __weak typeof(self) weakSelf = self;
        
        _bottomView.aaaaaa = ^(NSDictionary *keyWordInfo){
            weakSelf.commentsEditorView.hidden = NO;

            weakSelf.commentsEditorView.textView.text = @"sfds";
//            [weakSelf.commentsEditorView becomeFirstResponder];

        };
        
    }
    
    return _bottomView;
}
- (CBNCommentsEditorView *)commentsEditorView
{
    if (!_commentsEditorView) {
        
        self.commentsEditorView = [[CBNCommentsEditorView alloc] initWithFrame:CGRectMake(0, screen_Height-200 , screen_Width, 500)];
        
        _commentsEditorView.hidden = YES;
        
        
    }
    
    return _commentsEditorView;
}
/*
 *  设置NavigationHeaderBar
 */
- (void)setNavigationHeader
{
    CBNBarBurronItem *leftBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(leftBar:) andFrame:CGRectMake(0, 0, 30, 30) andImage:[UIImage imageNamed:@"userCenter_Day_Image@2x.png"]];
//
    CBNBarBurronItem *nightBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(nightBar:) andFrame:CGRectMake(0, 0, 44, 44) andImagePicker:DKImagePickerWithImages([UIImage imageWithColor:RGBColor(145, 145,145, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(103, 103,103, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(103, 103,103, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)])];
    CBNBarBurronItem *fontBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(fontBar:) andFrame:CGRectMake(0, 0, 44, 44) andImagePicker:DKImagePickerWithImages([UIImage imageWithColor:RGBColor(145, 145,145, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(103, 103,1033, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)],[UIImage imageWithColor:RGBColor(103, 103,103, 1) andFrame:CGRectMake(0, 0, screen_Width, 64)])];


    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.navigationItem.rightBarButtonItems= [NSArray arrayWithObjects:nightBar,fontBar,nil];
    
    [self.navigationController.navigationBar setBackgroundImage:[RGBColor(245, 245,245, 1) imageWithColor] forBarMetrics:UIBarMetricsDefault];

    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];

}


- (void)leftBar:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)nightBar:(id)sender
{
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        
        [self.dk_manager dawnComing];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xFFFFFF) andFrame:CGRectMake(0, 0, screen_Width, 44)]forBarMetrics:UIBarMetricsDefault];

    } else {

        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x00000) andFrame:CGRectMake(0, 0, screen_Width, 44)]forBarMetrics:UIBarMetricsDefaultPrompt];

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
        
        self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height-64)];
        
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
    return self.articleModel.block_list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CBNChaptBlockModel *chaptBlockModel = [_articleModel.block_list objectAtIndex:indexPath.row];
    
    
    if ([chaptBlockModel.blockType isEqualToString:@"text"]) {
        
        static NSString *identifier = @"ChaptBlockCell";
        
        CBNChaptBlockCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {

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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNChaptBlockModel *chaptBlockModel = [_articleModel.block_list objectAtIndex:indexPath.row];
    
    NSLog(@"%@",chaptBlockModel.blockImageContent.imageURL);

}
- (void)keyWordClicked:(NSDictionary *)sender
{
    CBNADWebVC *webVC = [[CBNADWebVC alloc] init];
    
    webVC.webURL = [[sender objectForKey:@"keyWordContent"] description];
    
    [self.navigationController pushViewController:webVC animated:YES];

}


@end
