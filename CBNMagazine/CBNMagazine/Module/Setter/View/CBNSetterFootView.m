//
//  CBNSetterFootView.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNSetterFootView.h"

@interface CBNSetterFootView ()
@property (nonatomic, strong) UILabel *companyLabel;
@end

@implementation CBNSetterFootView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.companyLabel];
        _companyLabel.frame = CGRectMake(0, self.frame.size.height - _companyLabel.frame.size.height -10, screen_Width, _companyLabel.frame.size.height);
        
    }
    return self;
}
- (UILabel *)companyLabel
{
    if (!_companyLabel) {
        
        self.companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, screen_Width, 0)];
        
        _companyLabel.text = @"@ 2016上海第一财经传媒有限公司";
        
        _companyLabel.textAlignment = 1;
        
        _companyLabel.font = font(12.0);
        
        _companyLabel.dk_textColorPicker = DKColorPickerWithKey(字体默认颜色);
        
        [_companyLabel sizeToFit];
    }
    
    return _companyLabel;
}
@end
