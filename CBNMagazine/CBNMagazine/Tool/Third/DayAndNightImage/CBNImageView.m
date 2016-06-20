//
//  CBNImageView.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNImageView.h"

@implementation CBNImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nightMaskImageView];
        
        self.backgroundColor = [UIColor yellowColor];
        
    }
    return self;
}
- (UIImageView *)nightMaskImageView
{
    if (!_nightMaskImageView) {
        
        self.nightMaskImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _nightMaskImageView.dk_backgroundColorPicker = image_Back_Mask;
        
    }
    return _nightMaskImageView;
}
- (void)setNeedsDisplay
{
    _nightMaskImageView.frame = self.bounds;
}

@end
