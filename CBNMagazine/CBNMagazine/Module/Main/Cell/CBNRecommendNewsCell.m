//
//  CBNRecommendNewsCell.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNRecommendNewsCell.h"
#import "CBNImageAndTextLabel.h"

#define imageView_Height 0.54*(320-20)*screen_Width/320

@interface CBNRecommendNewsCell ()
@property (nonatomic, strong) CBNImageView *newsThumbImageView;

@property (nonatomic, strong) CBNLabel *newsTitleLabel;

@property (nonatomic, strong) UILabel *timelabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) CBNImageAndTextLabel *praiseLabel;

@property (nonatomic, strong) CBNImageAndTextLabel *commentsCountLabel;

@end
@implementation CBNRecommendNewsCell
- (void)dealloc
{
    CBNLog(@"正常新闻cell释放了");
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.newsThumbImageView];
        [_newsThumbImageView addSubview:self.timelabel];

        [self addSubview:self.newsTitleLabel];
        
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _newsTitleLabel.frame.origin.y + _newsTitleLabel.frame.size.height+10);
        [self addSubview:self.lineImageView];
    }
    
    return self;
}

- (CBNImageView *)newsThumbImageView
{
    if (!_newsThumbImageView) {
        
        self.newsThumbImageView = [[CBNImageView alloc] initWithFrame:CGRectMake(10, 15, screen_Width-20, imageView_Height)];

        _newsThumbImageView.nightMaskImageView.dk_backgroundColorPicker= DKColorPickerWithColors(RGBColor(0, 0, 0, 0.26),RGBColor(0, 0, 0, 0.5),RGBColor(0, 0, 0, 0.26));
        _newsThumbImageView.image = [UIImage imageNamed:@"defaultImage.jpg"];
        
        [_newsThumbImageView addSubview:self.praiseLabel];
        
        [_newsThumbImageView addSubview:self.commentsCountLabel];
    }
    
    return _newsThumbImageView;
}

- (CBNLabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[CBNLabel alloc] initWithFrame:CGRectMake( 10, imageView_Height + 30, screen_Width - 20, 0)];
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(默认大标题字体颜色);
        _newsTitleLabel.font = font_px_bold(fontSize(48.0,42.0,36.0));
        
        _newsTitleLabel.lineSpace = 0.0;
        
        _newsTitleLabel.numberOfLines = 0;

        
        }
    
    return _newsTitleLabel;
}
- (CBNImageAndTextLabel *)praiseLabel
{
    if (!_praiseLabel) {
        
        self.praiseLabel = [[CBNImageAndTextLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) image:[UIImage imageWithColor:RGBColor(102, 198, 118, 1.0)]];
        _praiseLabel.contentLabel.dk_textColorPicker = DKColorPickerWithKey(默认背景上标签字体颜色);
        
          _praiseLabel.iconImageView.dk_imagePicker = DKImagePickerWithImages([UIImage imageNamed:@"praiseCount_white_Day.png"],[UIImage imageNamed:@"praiseCount_white_Day.png"],[UIImage imageNamed:@"praiseCount_white_Day.png"]);
    }
    
    return _praiseLabel;
}

- (CBNImageAndTextLabel *)commentsCountLabel
{
    if (!_commentsCountLabel) {
        
        self.commentsCountLabel = [[CBNImageAndTextLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) image:[UIImage imageWithColor:RGBColor(172, 108, 148, 1.0)]];
        
        _commentsCountLabel.contentLabel.dk_textColorPicker = DKColorPickerWithKey(默认背景上标签字体颜色);
        
        _commentsCountLabel.iconImageView.dk_imagePicker = DKImagePickerWithImages([UIImage imageNamed:@"commentsCount_white_Day.png"],[UIImage imageNamed:@"commentsCount_white_Day.png"],[UIImage imageNamed:@"commentsCount_white_Day.png"]);

    }
    
    return _commentsCountLabel;
}
- (UILabel *)timelabel
{
    if (!_timelabel) {
        
        self.timelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        _timelabel.dk_textColorPicker = DKColorPickerWithKey(默认背景上标签字体颜色);
        
        _timelabel.font = font_px(fontSize(36.0,31.0,26.0));
        
        _timelabel.numberOfLines = 0;
    }
    
    return _timelabel;
}
- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height -1, screen_Width, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(分割线默认颜色);
    }
    
    return _lineImageView;
}
- (void)setChannelNewsModel:(CBNChannelNewsModel *)channelNewsModel
{
    [_newsThumbImageView sd_setImageWithURL:[NSURL URLWithString:channelNewsModel.image] placeholderImage:[UIImage imageNamed:@"defaultImage.jpg"]];
    
    _timelabel.text = @"20.17.12.31";
    
    [_timelabel sizeToFit];
    
    _timelabel.frame = CGRectMake(12, imageView_Height - 10 - _timelabel.frame.size.height, _timelabel.frame.size.width, _timelabel.frame.size.height);
    
    _commentsCountLabel.text = @"999";
    
    CGFloat commentsWidth = _commentsCountLabel.frame.size.width + 7;
    
    _commentsCountLabel.frame = CGRectMake(_newsThumbImageView.frame.size.width - commentsWidth, imageView_Height - 12 - _commentsCountLabel.frame.size.height, _commentsCountLabel.frame.size.width, _commentsCountLabel.frame.size.height);
    
    _praiseLabel.text = @"99";
    
    CGFloat praiseWidth = _praiseLabel.frame.size.width + 18;
    
    _praiseLabel.frame = CGRectMake(_newsThumbImageView.frame.size.width - commentsWidth - praiseWidth, imageView_Height - 12 - _praiseLabel.frame.size.height, praiseWidth, _praiseLabel.frame.size.height);
    
    _newsTitleLabel.content = channelNewsModel.chapt_title;
    
    [_newsTitleLabel sizeToFit];
    
    _newsTitleLabel.frame = CGRectMake(_newsTitleLabel.frame.origin.x, _newsTitleLabel.frame.origin.y, screen_Width  - 20, _newsTitleLabel.frame.size.height);

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _newsTitleLabel.frame.origin.y + _newsTitleLabel.frame.size.height+16);
    
    _lineImageView.frame = CGRectMake(10, self.frame.size.height -1, screen_Width -20, 1);
}




@end
