//
//  CBNUserLoginVC.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNUserLoginVC.h"
#import "CBNLoginEvent.h"

@implementation CBNUserLoginVC
- (void)dealloc
{
    CBNLog(@"登录释放了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but.frame = CGRectMake(120, 120, 100, 100);
    
    but.backgroundColor = [UIColor redColor];
    
    [but addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:but];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but1.frame = CGRectMake(120, 250, 100, 100);
    
    but1.backgroundColor = [UIColor redColor];
    
    [but1 addTarget:self action:@selector(but1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:but1];
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but2.frame = CGRectMake(120, 380, 100, 100);
    
    but2.backgroundColor = [UIColor redColor];
    
    [but2 addTarget:self action:@selector(but2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:but2];
    
    
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but3.frame = CGRectMake(120, 500, 100, 100);
    
    but3.backgroundColor = [UIColor redColor];
    
    [but3 addTarget:self action:@selector(but3:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:but3];
}
- (void)login:(UIButton *)sender
{
    CBNLoginEvent *net = [[CBNLoginEvent alloc] init];
    
    [net CBNLoginWithUserID:@"huzhixin@yicai.com" password:@"cbnweek" secuessed:^(CBNUserModel *user) {
        
    } failed:^(NSError *error) {
        
    }];
    
}
- (void)but1:(UIButton *)sender
{
    NSLog(@"用户是否登录 -- %d",[CBNUserModel sharedInstance].isLogin);
    NSLog(@"%@",[CBNUserModel sharedInstance].avatar);
    
    
}
- (void)but2:(UIButton *)sender
{
//    [CBNLoginEvent loginOut];
    [[CBNUserModel sharedInstance] changeUserPropertyWithKey:@"avatar" andValue:@"avatar"];
    
//    NSLog(@"用户是否登录 -- %d",[CBNUserModel sharedInstance].isLogin);

}
- (void)but3:(UIButton *)sender
{
}

@end
