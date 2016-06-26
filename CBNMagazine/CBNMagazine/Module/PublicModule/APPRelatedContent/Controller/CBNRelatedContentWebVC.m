//
//  CBNRelatedContentWebVC.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNRelatedContentWebVC.h"

@interface CBNRelatedContentWebVC ()

@property (nonatomic, assign) CBNRelatedContentWebVCType relatedContentWebVCType;

@property (nonatomic, strong) NSString *webURL;

@property (nonatomic, strong) UIWebView *aWebView;
@end

@implementation CBNRelatedContentWebVC

- (void)dealloc
{
    NSLog(@"自己相关链接释放");
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]) {
        
        [storage deleteCookie:cookie];
        
    }
}
- (id)initWithRelatedContentWebVCType:(CBNRelatedContentWebVCType)relatedContentWebVCType
{
    self = [super init];
    
    if (self) {
        
        self.relatedContentWebVCType = relatedContentWebVCType;
        
        [self chooseWebURL];
        
    }
    
    return self;
}
- (void)chooseWebURL
{
    switch (_relatedContentWebVCType) {
        case CBNSina:
            
            self.webURL = @"http://weibo.com/cbnweekly";

            break;
            
        case CBNHelp:
            
            self.webURL = @"http://www.cbnweek.com/v/help";
            
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.aWebView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *webUrl = [NSURL URLWithString:self.webURL];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];
    
    [self.aWebView loadRequest:request];

    UIView *maskView = [[UIView alloc] initWithFrame:_aWebView.bounds];
    
    maskView.dk_backgroundColorPicker = image_Back_Mask;
    
    [self.view addSubview:maskView];
    
    maskView.userInteractionEnabled = NO;

}

- (UIWebView *)aWebView
{
    if (!_aWebView) {
        
        self.aWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        
    }
    
    return _aWebView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
