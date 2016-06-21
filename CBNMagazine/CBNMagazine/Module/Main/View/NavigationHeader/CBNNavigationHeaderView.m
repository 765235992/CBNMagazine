//
//  CBNNavigationHeaderView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/21.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNNavigationHeaderView.h"

@interface CBNNavigationHeaderView ()
@property (nonatomic, strong) UIButton *lefeButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIImageView *logoImageView;
@end

@implementation CBNNavigationHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self addSubview:self.maskImageView];
        
        [self addSubview:self.lefeButton];
        
        [self addSubview:self.rightButton];
        
        [self addSubview:self.logoImageView];
    }
    return self;
}
- (UIImageView *)maskImageView
{
    if (!_maskImageView) {
        
        self.maskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        _maskImageView.image = [UIImage imageWithColor:RGBColor(0, 0, 0, 0) andFrame:self.bounds];
    }
    
    return _maskImageView;
}
- (UIButton *)lefeButton
{
    if (!_lefeButton) {
        
        self.lefeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _lefeButton.frame = CGRectMake(10, 25, 30, 30);
        
        [_lefeButton setImage:[UIImage imageNamed:@"user_Center_Day@2x.png"] forState:UIControlStateNormal];
        
    }
    
    return _lefeButton;
}
- (UIButton *)rightButton
{
    if (!_rightButton) {
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightButton.frame = CGRectMake(screen_Width-40, 25, 30, 30);
        
        [_rightButton setImage:[UIImage imageNamed:@"book_Shop_Day@2x.png"] forState:UIControlStateNormal];
        
    }
    
    return _rightButton;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        
        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 400/3, 44)];
//        _logoImageView.backgroundColor = [UIColor redColor];
        
        _logoImageView.image = [UIImage imageNamed:@"navigation_Logo_Day@3x.png"];
        
        _logoImageView.center = CGPointMake(screen_Width/2, _logoImageView.center.y);
    }
    
    return _logoImageView;
}

@end
