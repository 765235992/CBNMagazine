//
//  CBNMainNavigationVC.m
//  CBNMagazine
//
//  Created by Jim on 16/6/21.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNMainNavigationVC.h"

@interface CBNMainNavigationVC ()

@end

@implementation CBNMainNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor] andFrame:CGRectMake(0, 0, screen_Width, 1)]];
//    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
//    //设置轻扫的方向
//    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight; //默认向右
//    [self.view addGestureRecognizer:swipeGesture];
}
- (void)swipeGesture:(id)sender
{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
