//
//  CBNShufflingCell.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNShufflingCell.h"
#define pageControlHeight 20
#define myWidth self.frame.size.width
#define myHeight self.frame.size.height
#define pageSize (myHeight * 0.2 > 25 ? 25 : myHeight * 0.2)

@interface CBNShufflingCell ()

//@property (nonatomic, strong) cbnShufflingImageRequestHelper *requestHelper;


@end
@implementation CBNShufflingCell
- (id)initWithFrame:(CGRect)frame andDefaultImage:(UIImage *)defaultImage
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.maskImageView];
        
        /*
         *  默认背景图片
         */
        self.image = defaultImage;
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.newsTitleLabel];
        
        _newsTitleLabel.center = CGPointMake(screen_Width/2, screen_Height/2);
        
    }
    
    return self;
}



- (UIImageView *)maskImageView
{
    if (!_maskImageView) {
        
        self.maskImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        _maskImageView.dk_backgroundColorPicker = DKColorPickerWithColors(RGBColor(0, 0, 0, 0.4),RGBColor(0, 0, 0, 0.4),RGBColor(0, 0, 0, 0.4));
    }
    
    return _maskImageView;
}

- (CBNLabel *)newsTitleLabel
{
    
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(23, myHeight-pageControlHeight , myWidth-46, 0)];
        
        _newsTitleLabel.isCenter = YES;
        
        _newsTitleLabel.lineSpace = 0;
        
        _newsTitleLabel.font = font_px_Medium(fontSize(72.0,64.0,56.0));
        
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(默认背景颜色);
        
    }
    
    return _newsTitleLabel;
    
}

- (void)setShufflingModel:(CBNShufflingModel *)shufflingModel
{
    
    _newsTitleLabel.content =shufflingModel.newsTitleStr;
    
    _newsTitleLabel.textAlignment = 1;

    [_newsTitleLabel sizeToFit];
    
    _newsTitleLabel.frame = CGRectMake(_newsTitleLabel.frame.origin.x, self.frame.size.height - 20*1.8 - _newsTitleLabel.frame.size.height, screen_Width - 46, _newsTitleLabel.frame.size.height);
    
    _newsTitleLabel.center = CGPointMake(myWidth/2, (myHeight)/2 + 32 );
    
    [self sd_setImageWithURL:[NSURL URLWithString:shufflingModel.newsThumbStr] placeholderImage:shufflingModel.newsDefaultImage];
    
    
}

@end
