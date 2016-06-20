//
//  CBNChaptImageCell.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptImageCell.h"

#import "CBNImageView.h"


@interface CBNChaptImageCell ()
@property (nonatomic, strong) CBNImageView *newsImageView;

@end

@implementation CBNChaptImageCell

- (void)dealloc
{
    NSLog(@"释放%@",self);
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.newsImageView];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}
- (CBNImageView *)newsImageView
{
    if (!_newsImageView) {
        
        self.newsImageView = [[CBNImageView alloc] initWithFrame:CGRectMake(10, 10, screen_Width-20, 250)];
        //        _newsImageView.contentMode =  UIViewContentModeScaleAspectFit;
        _newsImageView.backgroundColor = [UIColor clearColor];

    }
    
    return _newsImageView;
}
- (void)setChaptBlockModel:(CBNChaptBlockModel *)chaptBlockModel
{
    _chaptBlockModel = chaptBlockModel;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [_newsImageView sd_setImageWithURL:[NSURL URLWithString:chaptBlockModel.blockImageContent.imageURL] placeholderImage:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
        });
        
    });
    NSLog(@"%f  %f",chaptBlockModel.blockImageContent.imageWidth,chaptBlockModel.blockImageContent.imageHeight);
    CGFloat width = chaptBlockModel.blockImageContent.imageWidth;
    CGFloat height = chaptBlockModel.blockImageContent.imageHeight;
    if (width > screen_Width-20) {
        width = screen_Width-20;
        height = (screen_Width-20)*height/chaptBlockModel.blockImageContent.imageWidth;
    }
    
    _newsImageView.frame = CGRectMake(10, 10, width, height);
    
    _newsImageView.center = CGPointMake(screen_Width/2, _newsImageView.center.y);
    
    _newsImageView.nightMaskImageView.frame = _newsImageView.bounds;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
    
    _chaptBlockModel.height = height + 20;
    
    [self setNeedsDisplay];
    
    [self setNeedsLayout];
}

@end
