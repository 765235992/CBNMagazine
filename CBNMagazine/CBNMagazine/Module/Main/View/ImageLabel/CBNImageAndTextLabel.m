//
//  CBNImageAndTextLabel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNImageAndTextLabel.h"

@interface CBNImageAndTextLabel ()

@property (nonatomic, strong) UIImage *image;


//@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CBNImageAndTextLabel
- (void)dealloc
{
    CBNLog(@"CBNImageAndTextLabel 释放了");
}
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = image;
        
        [self addSubview:self.iconImageView];
        
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _iconImageView.image = self.image;
        
        
    }
    
    return _iconImageView;
}

- (CBNLabel *)contentLabel
{
    if (!_contentLabel) {
        
        self.contentLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(25, 0, 0, 0)];
        
        _contentLabel.font = font_px(fontSize(36.0,31.0,26.0));
        
    }
    
    return _contentLabel;
}


- (void)setText:(NSString *)text
{
    _contentLabel.text = text;
    
    [_contentLabel sizeToFit];
    
    _iconImageView.frame = CGRectMake(0, 0, _contentLabel.frame.size.height, _contentLabel.frame.size.height);
    
    _contentLabel.frame =  CGRectMake(_contentLabel.frame.size.height + 5, 0, _contentLabel.frame.size.width, _contentLabel.frame.size.height);
    
    self.frame = CGRectMake(0, 0, _contentLabel.frame.origin.x + _contentLabel.frame.size.width , _contentLabel.frame.size.height);
    
}

















@end
