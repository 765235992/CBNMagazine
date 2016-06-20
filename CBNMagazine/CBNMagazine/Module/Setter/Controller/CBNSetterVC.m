//
//  CBNSetterVC.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNSetterVC.h"
#import <MessageUI/MessageUI.h>

#import "CBNTextCell.h"
#import "CBNArrowsCell.h"
#import "CBNSwitchCell.h"
#import "CBNSetterFootView.h"
#import "CBNRelatedContentWebVC.h"
#import "CBNSynchronousPermissionsVC.h"
static NSString * const CBNWEEK_EMAIL = @"zkkf@cbnweek.com";

@interface CBNSetterVC ()<UITableViewDelegate, UITableViewDataSource,CBNSwitchCellDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UITableView *aTableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) CBNSetterFootView *aTableViewFootView;
@end

@implementation CBNSetterVC
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavigationHeader];

    self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xDBDBDB,0x363636,0xDBDBDB);
    
    [self.view addSubview:self.aTableView];
    /*
     *  设置一般有5种类型
     *
     *  1、左边文字，右边箭头
     *
     *
     */

    CBNLog(@"可以下载否%d",[[CBNNetworkStateManager sharedClient] currentNetworkCanDoSomeing]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
   
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
            
            NSArray *arr =[NSArray arrayWithContentsOfFile: [[CBNFileManager sharedInstance] loadPlistFilePathWithPlistName:@"CBNSetter"]];
            
            [[CBNFileManager sharedInstance] saveBasicDataTypes:arr withKey:@"setter"];
            
        }
        
        [self.sourceArray addObjectsFromArray:[[CBNFileManager sharedInstance] loadBasicDataTypesWithKey:@"setter"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [_aTableView reloadData];
            
        });
        
    });
    
    
}
- (void)setNavigationHeader
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    titleLabel.dk_textColorPicker = DKColorPickerWithKey(字体默认颜色);
    
    titleLabel.text = @"设置";
    
    titleLabel.font = font(18.0);
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
  
    self.navigationItem.titleView = titleLabel;

}
- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
        
    }
    
    return _sourceArray;
}
- (UITableView *)aTableView
{
    if (!_aTableView) {
        self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xDBDBDB,0x363636,0xDBDBDB);
        
        _aTableView.tableFooterView = self.aTableViewFootView;

    }
    
    return _aTableView;
    
}
- (CBNSetterFootView *)aTableViewFootView
{
    if (!_aTableViewFootView) {
        
        self.aTableViewFootView = [[CBNSetterFootView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 50)];
        
        
    }
    
    return _aTableViewFootView;
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sourceArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *tempDic = [[self.sourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSString *type = tempDic[@"type"];
    
    if ([type isEqualToString:@"arrows"]) {
        static NSString *indentfier = @"CBNArrowsCell";
        
        CBNArrowsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfier];
        
        if (cell == nil) {
            
            cell = [[CBNArrowsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentfier];
            
        }
        cell.setterDic = tempDic;
        
        return cell;
    }
    
    if ([type isEqualToString:@"switch"]) {
        
        static NSString *indentfier = @"CBNSwitchCell";
        
        CBNSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfier];
        
        if (cell == nil) {
            cell = [[CBNSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentfier];
            cell.delegate = self;
            
            
        }
        [cell configureTheSetterItem:tempDic AtIndexPath:indexPath];
        
        return cell;
    }
    static NSString *indentfier = @"JHSSliderCell";

    CBNTextCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfier];
    
    if (cell == nil) {
        cell = [[CBNTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentfier];
        
    }
    cell.setterDic = tempDic;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 2:
                /*
                 *  清除本地缓存
                 */
                [self cleanCache];
                
                break;
            case 3:
                /*
                 *  评分
                 */
                [self toScore];
                
                break;
            case 4:
                /*
                 *  发邮件
                 */
                [self sendEmailToCBN];
                
                break;
            case 5:
                /*
                 *  复制微信号
                 */
                [self copyWechatSession];
                
                break;
            case 6:
                /*
                 *  微博
                 */
                [self toSina];
                
                break;
            case 7:
                /*
                 *  微博
                 */
                [self toHelp];
                
                break;
            default:
                break;
        }
    }else if (indexPath.section ==1 ){
        switch (indexPath.row) {
            case 0:
    
                
                break;
            case 1:
                /*
                 *  同步权限
                 */
                [self toSynchronousPermissions];
                
                break;
            case 2:
           
                
                break;
            default:
                break;
        }

    }
}
/*
 *  清除本地缓存
 */
- (void)cleanCache
{
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache]clearDisk];
}
/*
 *  去评分
 */
- (void)toScore
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", @"916133320"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)sendEmailToCBN
{
    BOOL canSendMail = [MFMailComposeViewController canSendMail];
    if (canSendMail) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
        mail.mailComposeDelegate = self;
        mail.navigationBar.tintColor = [UIColor blackColor];
        [mail setToRecipients:@[CBNWEEK_EMAIL]];
        [self presentViewController:mail animated:YES completion:^{}];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"尚未添加邮箱" message:@"请您前往：设置->邮件->添加账户。已完成邮件发送" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
    }

}
/*
 *  复制微信号
 */
- (void)copyWechatSession
{
    [[UIPasteboard generalPasteboard] setValue:@"CBNweekly2008" forPasteboardType:@"public.utf8-plain-text"];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"微信公众号CBNweekly2008已成功复制,您可登录微信进行搜索添加" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
/*
 *  新浪微博
 */
- (void)toSina
{
    CBNRelatedContentWebVC *relatedContentWebVC = [[CBNRelatedContentWebVC alloc] initWithRelatedContentWebVCType:CBNSina];
    
    [self.navigationController pushViewController:relatedContentWebVC animated:YES];
    
}
/*
 *  同步权限
 */
- (void)toSynchronousPermissions
{
    CBNSynchronousPermissionsVC *synchronousPermissionsVC = [[CBNSynchronousPermissionsVC alloc] init];
    
    [self.navigationController pushViewController:synchronousPermissionsVC animated:YES];
    
}
/*
 *  新浪微博
 */
- (void)toHelp
{
    CBNRelatedContentWebVC *relatedContentWebVC = [[CBNRelatedContentWebVC alloc] initWithRelatedContentWebVCType:CBNHelp];
    
    [self.navigationController pushViewController:relatedContentWebVC animated:YES];
    
}
#define mark CBNSwitchCellDelegate

- (void)switchChanged:(CBNSwitchCell *)switchCell andSwicth:(UISwitch *)sender
{
    /*
     *  先取出来这个字典的位置
     */
    NSDictionary *result = [self needFixResultAtIndex:switchCell.indexPath withValue:[NSString stringWithFormat:@"%d",sender.on]];
    
    if (switchCell.indexPath.row == 0) {
        
        [self nightOrDayStyle];
        
    }else if (switchCell.indexPath.row == 1){

    }
    /*
     *  开始修改数组
     */
    [self saveFixResultAtIndex:switchCell.indexPath withResult:result];
}
/*
 *  夜间模式转换
 */
- (void)nightOrDayStyle
{
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        
        [self.dk_manager dawnComing];
        
    } else {
        
        [self.dk_manager nightFalling];
        
    }
}
#define mark 帮助方法
/*
 *  修改结果中的value值，直接对字典进行修改
 */
- (NSDictionary *)needFixResultAtIndex:(NSIndexPath *)indexPath withValue:(NSString *)value
{
    
    NSDictionary *resultDic = [[_sourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    
    [tempDic setValue:[NSString stringWithFormat:@"%@",value] forKey:@"value"];
    
    return tempDic;
}
/*
 *  保存修改结果，一层一层的进行修改
 */
- (void)saveFixResultAtIndex:(NSIndexPath *)indexPath withResult:(NSDictionary *)result
{
    
    NSMutableArray *lastArray = [NSMutableArray arrayWithArray:[_sourceArray objectAtIndex:indexPath.section]];
    
    [lastArray replaceObjectAtIndex:indexPath.row withObject:result];
    
    [_sourceArray replaceObjectAtIndex:indexPath.section withObject:lastArray];
    /*
     *  正式使用时要在dealloc中进行最后缓存，这个地方进行删除
     */
    [[CBNFileManager sharedInstance] saveBasicDataTypes:_sourceArray withKey:@"setter"];
   
}

#pragma mark - MFMailComposeViewControllerDelegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [controller dismissViewControllerAnimated:NO completion:nil];
    //不能为YES
    switch (result) {
        case MFMailComposeResultCancelled:
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MFMailComposeResultFailed:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MFMailComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MFMailComposeResultSaved:
            [self alertWithTitle:@"提示信息" msg:@"存储草稿"];
            break;
        default:
            break;
    }
}

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    alert.tag = 10000;
    [alert show];
}
@end
