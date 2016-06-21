//
//  CBNArticleHeaderNormalView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNArticleHeaderNormalView.h"

@implementation CBNArticleHeaderNormalView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dk_backgroundColorPicker = DKColorPickerWithKey(默认背景颜色);
        
        [self addSubview:self.newsThumbImageView];
        
        [self addSubview:self.newsTitleLabel];
        
        [self addSubview:self.newsNotesLabel];
        
        [self addSubview:self.authorLabel];
        
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.lineImageView];
        
        [self addSubview:self.newsNotesLabel];
        
        [self addSubview:self.audioView];
        
        
    }
    return self;
}

- (CBNImageView *)newsThumbImageView
{
    if (!_newsThumbImageView) {
        
        self.newsThumbImageView = [[CBNImageView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Width*0.54)];
        
        _newsThumbImageView.image = [UIImage imageNamed:@"defaultImage.jpg"];
    }
    
    return _newsThumbImageView;
}
- (CBNLabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(10, _newsThumbImageView.frame.size.height +15, screen_Width-20, 0)];
        _newsTitleLabel.backgroundColor = [UIColor clearColor];
        
        
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(默认大标题字体颜色);
        
        _newsTitleLabel.font = font_px_bold(fontSize(56.0,52.0,48.0));
        
    }
    
    return _newsTitleLabel;
}


- (JHCTLabel *)authorLabel
{
    if (!_authorLabel) {
        
        self.authorLabel = [[JHCTLabel alloc] initWithFrame:CGRectMake(10, 100, 200,100)];
        
        _authorLabel.backgroundColor = [UIColor clearColor];
        
        
    }
    
    return _authorLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(默认标签字体颜色);
        
        _timeLabel.font = font_px(fontSize(42.0,36.0,36.0));
    }
    
    return _timeLabel;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(分割线默认颜色);
        
    }
    
    return _lineImageView;
}

- (CBNLabel *)newsNotesLabel
{
    if (!_newsNotesLabel) {
        
        self.newsNotesLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(10, 0, screen_Width-20, 0)];
        _newsNotesLabel.numberOfLines = 0;
        
        _newsNotesLabel.dk_textColorPicker = DKColorPickerWithKey(默认大标题字体颜色);
        _newsNotesLabel.font = font_px(fontSize(42.0,36.0,36.0));
        
    }
    
    return _newsNotesLabel;
}
- (CBNChaptAudioView *)audioView
{
    if (!_audioView) {
        
        self.audioView = [[CBNChaptAudioView alloc] initWithFrame:CGRectMake(10, _newsNotesLabel.frame.size.height + _newsNotesLabel.frame.origin.y + 10, screen_Width-20, 0)];
    }
    
    return _audioView;
}
- (void)setChapt_Info_Model:(CBNChaptInfoModel *)chapt_Info_Model
{
    
    _chapt_Info_Model = chapt_Info_Model;
    
    self.newsTitleLabel.content = chapt_Info_Model.chaptTitle;
    
    [_newsTitleLabel sizeToFit];
    
    
}

- (void)setAuthor_List:(NSArray *)author_List
{
    
    CGFloat titleHeight = _newsTitleLabel.frame.size.height + _newsTitleLabel.frame.origin.y + 20;
    
    _timeLabel.text = @"2016.12.30";
    [_timeLabel sizeToFit];
    _timeLabel.frame = CGRectMake(self.frame.size.width - 10 - _timeLabel.frame.size.width, titleHeight , _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    _authorLabel.sourceArray = author_List;
    
    _authorLabel.frame = CGRectMake(10, titleHeight , self.frame.size.width - 30 - _timeLabel.frame.size.width, _authorLabel.frame.size.height);
    
    _authorLabel.backgroundColor = [UIColor clearColor];
    
    
    _lineImageView.frame = CGRectMake(0, _authorLabel.frame.origin.y + _authorLabel.frame.size.height + 20, screen_Width, 1);
    
    
    _newsNotesLabel.content = _chapt_Info_Model.chaptBrief;
    
    [_newsNotesLabel sizeToFit];
    
    _newsNotesLabel.frame = CGRectMake(10, _lineImageView.frame.origin.y + _lineImageView.frame.size.height + 20, screen_Width-20, _newsNotesLabel.frame.size.height);
    
    _audioView.frame = CGRectMake(10, _newsNotesLabel.frame.size.height + _newsNotesLabel.frame.origin.y + 10, screen_Width-20, _audioView.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _audioView.frame.origin.y + _audioView.frame.size.height);
    
}

@end
