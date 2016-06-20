//
//  CBNForgetVC.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNForgetVC.h"

@implementation CBNForgetVC
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
    
    
}
- (void)but1:(UIButton *)sender
{
    
}
- (void)but2:(UIButton *)sender
{
    
    
}
- (void)but3:(UIButton *)sender
{
}

@end
