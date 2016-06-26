//
//  CBNNormalNewsCell.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNNormalNewsCell.h"
#import "CBNImageAndTextLabel.h"

#define imageView_With 128*screen_Width/320
#define imageView_Height 0.54*128*screen_Width/320

@interface CBNNormalNewsCell ()
@property (nonatomic, strong) CBNImageView *newsThumbImageView;

@property (nonatomic, strong) CBNLabel *newsTitleLabel;

@property (nonatomic, strong) UILabel *timelabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) CBNImageAndTextLabel *praiseLabel;

@property (nonatomic, strong) CBNImageAndTextLabel *commentsCountLabel;

@end

@implementation CBNNormalNewsCell
- (void)dealloc
{
    CBNLog(@"正常新闻cell释放了");
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.dk_backgroundColorPicker = DKColorPickerWithKey(默认背景颜色);

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.newsThumbImageView];
        
        [self addSubview:self.newsTitleLabel];
        
        [self addSubview:self.timelabel];
        
        [self addSubview:self.praiseLabel];
        
        [self addSubview:self.commentsCountLabel];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, imageView_Height + 31);
        
        [self addSubview:self.lineImageView];

    }
    
    return self;
}

- (CBNImageView *)newsThumbImageView
{
    if (!_newsThumbImageView) {
        
        self.newsThumbImageView = [[CBNImageView alloc] initWithFrame:CGRectMake(12, 15, imageView_With, imageView_Height)];
        
        _newsThumbImageView.image = [UIImage imageNamed:@"defaultImage.jpg"];
    }
    
    return _newsThumbImageView;
}

- (CBNLabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[CBNLabel alloc] initWithFrame:CGRectMake( imageView_With + 24, 15, screen_Width - imageView_With - 30, 0)];
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);

        _newsTitleLabel.font = font_px_Medium(fontSize(44.0,40.0,36.0));

        _newsTitleLabel.lineSpace = 0.0;

        _newsTitleLabel.numberOfLines = 2;
       
    }
    
    return _newsTitleLabel;
}
- (UILabel *)timelabel
{
    if (!_timelabel) {
        
        self.timelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        _timelabel.dk_textColorPicker = DKColorPickerWithKey(白色背景上的默认标签字体颜色);

        _timelabel.font = font_px_Medium(fontSize(36.0,31.0,26.0));
    }
    
    return _timelabel;
}
- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.frame.size.height -1, screen_Width-20, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(新闻列表分割线颜色);
    }
    
    return _lineImageView;
}
- (CBNImageAndTextLabel *)praiseLabel
{
    if (!_praiseLabel) {
        
        self.praiseLabel = [[CBNImageAndTextLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) image:[UIImage imageWithColor:RGBColor(102, 198, 118, 1.0)]];
        
        _praiseLabel.contentLabel.dk_textColorPicker = DKColorPickerWithKey(白色背景上的默认标签字体颜色);
        
        _praiseLabel.iconImageView.dk_imagePicker = DKImagePickerWithImages([UIImage imageNamed:@"praiseCount_gray_Day.png"],[UIImage imageNamed:@"praiseCount_gray_Day.png"],[UIImage imageNamed:@"praiseCount_gray_Day.png"]);
    }
    
    return _praiseLabel;
}

- (CBNImageAndTextLabel *)commentsCountLabel
{
    if (!_commentsCountLabel) {
        
        self.commentsCountLabel = [[CBNImageAndTextLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) image:[UIImage imageWithColor:RGBColor(172, 108, 148, 1.0)]];
        
        _commentsCountLabel.contentLabel.dk_textColorPicker = DKColorPickerWithKey(白色背景上的默认标签字体颜色);
        
        _commentsCountLabel.iconImageView.dk_imagePicker = DKImagePickerWithImages([UIImage imageNamed:@"commentsCount_gray_Day.png"],[UIImage imageNamed:@"praiseCount_white_Day.png"],[UIImage imageNamed:@"commentsCount_gray_Day.png"]);
    }
    
    return _commentsCountLabel;
}

- (void)setChannelNewsModel:(CBNChannelNewsModel *)channelNewsModel
{
    [_newsThumbImageView sd_setImageWithURL:[NSURL URLWithString:channelNewsModel.cover_img_big] placeholderImage:[UIImage imageNamed:@"defaultImage.jpg"]];
    
//    _newsTitleLabel.content = channelNewsModel.chapt_title;
_newsTitleLabel.content = @"中投财团收购百盛中国股权的谈判宣告破裂";
    [_newsTitleLabel sizeToFit];
    
    _newsTitleLabel.frame = CGRectMake(_newsTitleLabel.frame.origin.x, 15, screen_Width - imageView_With - 30, _newsTitleLabel.frame.size.height);
    
    _timelabel.text = [NSDate getUTCFormateDate:channelNewsModel.renew_time];
    
    [_timelabel sizeToFit];
    
    _timelabel.frame = CGRectMake(imageView_With + 24, imageView_Height + 15 - _timelabel.frame.size.height, _timelabel.frame.size.width, _timelabel.frame.size.height);
    
    _commentsCountLabel.frame = CGRectMake(0, 0, 0, 0);
    
    _commentsCountLabel.text = [NSString stringWithFormat:@"%ld",[channelNewsModel.comments integerValue]];
    
    CGFloat commentsWidth = _commentsCountLabel.frame.size.width + 10;
    
    _commentsCountLabel.frame = CGRectMake(screen_Width - commentsWidth, imageView_Height + 15 - _commentsCountLabel.frame.size.height, _commentsCountLabel.frame.size.width, _commentsCountLabel.frame.size.height);
    _praiseLabel.frame = CGRectMake(0, 0, 0, 0);

    _praiseLabel.text =  [NSString stringWithFormat:@"%ld",[channelNewsModel.like integerValue]];
    
    CGFloat praiseWidth = _praiseLabel.frame.size.width + 12;
    
    _praiseLabel.frame = CGRectMake(screen_Width - commentsWidth - praiseWidth, imageView_Height + 15 - _praiseLabel.frame.size.height, praiseWidth, _praiseLabel.frame.size.height);
    
    _channelNewsModel = channelNewsModel;

    _channelNewsModel.height = self.frame.size.height;
    
    [self setNeedsDisplay];
    
    [self setNeedsLayout];
    [_timelabel setNeedsLayout];
    [_timelabel setNeedsDisplay];

}












@end
