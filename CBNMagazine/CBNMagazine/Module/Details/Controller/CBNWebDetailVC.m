//
//  CBNWebDetailVC.m
//  CBNMagazine
//
//  Created by Jim on 16/6/23.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNWebDetailVC.h"
#import "UIColor+Extension.h"

@interface CBNWebDetailVC ()
@property (nonatomic, strong) UIWebView *adWebView;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation CBNWebDetailVC

- (void)dealloc
{
    NSLog(@"广告链接释放");
//    NSHTTPCookie *cookie;
//    
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    
//    for (cookie in [storage cookies]) {
//        
//        [storage deleteCookie:cookie];
//        
//    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
        
    [self.navigationController.navigationBar setBackgroundImage:[UIColorFromRGB(0xFFFFF0) imageWithColor] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];

    [self.view addSubview:self.adWebView];
    [_adWebView addSubview:self.maskView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *webUrl = [NSURL URLWithString:self.webURL];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];
    
    [self.adWebView loadRequest:request];
}
- (UIWebView *)adWebView
{
    if (!_adWebView) {
        
        self.adWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        
    }
    
    return _adWebView;
}
- (UIView *)maskView
{
    if (!_maskView) {
        
        self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        _maskView.dk_backgroundColorPicker = image_Back_Mask;
        
        _maskView.userInteractionEnabled = NO;
        
        _maskView.multipleTouchEnabled = YES;
        
    }
    
    return _maskView;
}




@end
