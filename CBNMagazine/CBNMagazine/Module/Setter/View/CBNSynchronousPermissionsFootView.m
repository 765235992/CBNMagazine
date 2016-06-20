//
//  CBNSynchronousPermissionsFootView.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNSynchronousPermissionsFootView.h"

@interface CBNSynchronousPermissionsFootView ()
@property (nonatomic, strong) UIButton *synchronousButton;
@end

@implementation CBNSynchronousPermissionsFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.synchronousButton];
        
    }
    
    return self;
}
- (UIButton *)synchronousButton
{
    if (!_synchronousButton) {
        
        self.synchronousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _synchronousButton.frame = CGRectMake(20, 20, screen_Width-40, 44);
        
        _synchronousButton.backgroundColor = [UIColor redColor];
        
        _synchronousButton.dk_backgroundColorPicker = DKColorPickerWithKey(按钮默认背景颜色);
        
        _synchronousButton.titleLabel.dk_textColorPicker = DKColorPickerWithKey(字体默认颜色);
        
        [_synchronousButton setTitle:@"同步权限" forState:UIControlStateNormal];
        
        [_synchronousButton addTarget:self action:@selector(synchronousButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _synchronousButton;
}
- (void)synchronousButton:(UIButton *)sender
{
    if (self.synchronousButtonClicked!=nil) {
        self.synchronousButtonClicked();
    }
}




@end
