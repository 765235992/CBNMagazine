//
//  CBNSynchronousPermissionsVC.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNSynchronousPermissionsVC.h"
#import "CBNSynchronousPermissionsCell.h"
#import "CBNSynchronousPermissionsFootView.h"
#import "CBNUserLoginVC.h"

@interface CBNSynchronousPermissionsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) CBNSynchronousPermissionsFootView *synchronousPermissionsFootVie;

@property (nonatomic, strong) NSMutableArray *sourceArray;
@end

@implementation CBNSynchronousPermissionsVC
- (void)dealloc
{
    CBNLog(@"释放了同步权益");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(默认背景颜色);

    [self.view addSubview:self.backgroundImageView];
    
    [self.view addSubview:self.aTableView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
      
        
        [self.sourceArray addObjectsFromArray:[NSArray arrayWithContentsOfFile: [[CBNFileManager sharedInstance] loadPlistFilePathWithPlistName:@"CBNSynchronousPermissions"]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [_aTableView reloadData];
            
        });
        
    });

    
}
- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
 
        self.sourceArray = [[NSMutableArray alloc] init];
    }
    
    return _sourceArray;
}
- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
    }
    
    return _backgroundImageView;
}

- (UITableView *)aTableView
{
    if (!_aTableView) {
        self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xDBDBDB,0x363636,0xDBDBDB);
        
        _aTableView.tableFooterView = self.synchronousPermissionsFootVie;
        
    }
    
    return _aTableView;

}
- (CBNSynchronousPermissionsFootView *)synchronousPermissionsFootVie
{
    if (!_synchronousPermissionsFootVie ) {
        
        self.synchronousPermissionsFootVie = [[CBNSynchronousPermissionsFootView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 84)];
        
        __weak typeof(self) weakSelf = self;
        
        _synchronousPermissionsFootVie.synchronousButtonClicked = ^(){
            
            [weakSelf synchronousButtonClicked];
            
        };
    }
    
    return _synchronousPermissionsFootVie;
}
/*
 *  同步权限
 */
- (void)synchronousButtonClicked
{
    /*
     *  首先判断是否登录
     */
    
    if ([CBNUserModel sharedInstance].isLogin  == YES) {
        /*
         *  如果登录了
         */
        CBNLog(@"是否绑定了第一财经账号：%@",[CBNUserModel sharedInstance].isBind);
        
    }else{

        CBNUserLoginVC *loginVC = [[CBNUserLoginVC alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 84;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.synchronousPermissionsFootVie;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"CBNSynchronousPermissionsCell";
    
    CBNSynchronousPermissionsCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (!cell) {
        
        cell = [[CBNSynchronousPermissionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
    }
    
    cell.synchronousPermissionsText = [_sourceArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNSynchronousPermissionsCell *cell = (CBNSynchronousPermissionsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
@end
