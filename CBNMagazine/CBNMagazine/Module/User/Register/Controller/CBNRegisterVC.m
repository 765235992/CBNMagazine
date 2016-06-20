//
//  CBNRegisterVC.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNRegisterVC.h"
#import "CBNRegisterEvent.h"

@implementation CBNRegisterVC
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
    
    but1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 250, 300, 70)];
    
    
    but1.backgroundColor = [UIColor redColor];
    
    
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

    registe = [[CBNRegisterEvent alloc] init];
    
    [registe registerEventUserIDIsRegister:@"13837833525" secuessed:^(id result) {
        
    } failed:^(NSError *error) {
        
    }];
}
- (void)but1:(UIButton *)sender
{
    
}
- (void)but2:(UIButton *)sender
{
 [registe registerCheckVerificationCodeIsEffectiveEventWithUserInfo:but1.text secuessed:^(id result) {
     
 } failed:^(id error) {
     
 }];
    
    
}
- (void)but3:(UIButton *)sender
{
    
    NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
    
    [user setObject:@"13837833525" forKey:@"phone"];
    [user setObject:@"阿里" forKey:@"nickname"];
    [user setObject:@"12345678" forKey:@"pwd"];
    
    [registe registerOverWithUserInfo:user secuessed:^(id result) {
        
    } failed:^(id error) {
        
    }];
}
- (void)dealloc
{
    NSLog(@"释放");
}
@end
