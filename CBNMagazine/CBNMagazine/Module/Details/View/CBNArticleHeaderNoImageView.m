//
//  CBNArticleHeaderNoImageView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNArticleHeaderNoImageView.h"

@implementation CBNArticleHeaderNoImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dk_backgroundColorPicker = DKColorPickerWithKey(默认背景颜色);
        
        [self addSubview:self.newsTitleLabel];
        
        [self addSubview:self.newsNotesLabel];
        
        [self addSubview:self.authorLabel];
        
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.lineImageView];
        
        [self addSubview:self.newsNotesLabel];
        
        
    }
    return self;
}


- (UILabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, screen_Width-20, 0)];
        _newsTitleLabel.backgroundColor = [UIColor clearColor];
        
        _newsTitleLabel.numberOfLines = 0;
        
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
        _newsTitleLabel.font = font_px_Medium(20);
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
        
    }
    
    return _timeLabel;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(默认分割线颜色);
        
    }
    
    return _lineImageView;
}

- (UILabel *)newsNotesLabel
{
    if (!_newsNotesLabel) {
        
        self.newsNotesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen_Width-20, 0)];
        _newsNotesLabel.numberOfLines = 0;
        
        _newsNotesLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
        _newsNotesLabel.font = font_px_Medium(14);
        
    }
    
    return _newsNotesLabel;
}
- (void)setChapt_Info_Model:(CBNChaptInfoModel *)chapt_Info_Model
{
    
    _chapt_Info_Model = chapt_Info_Model;
    
    self.newsTitleLabel.attributedText = [_newsTitleLabel titleLabelAttributedStringWithString:chapt_Info_Model.chaptTitle];
    
    [_newsTitleLabel sizeToFit];
    
    
}

- (void)setAuthor_List:(NSArray *)author_List
{
    _authorLabel.sourceArray = author_List;
    
    _authorLabel.frame = CGRectMake(10, _newsTitleLabel.frame.size.height + 20, _authorLabel.frame.size.width, _authorLabel.frame.size.height);
    
    _authorLabel.backgroundColor = [UIColor clearColor];
    
    
    _lineImageView.frame = CGRectMake(0, _authorLabel.frame.origin.y + _authorLabel.frame.size.height + 10, screen_Width, 1);
    
    
    _newsNotesLabel.attributedText = [_newsNotesLabel titleLabelAttributedStringWithString:_chapt_Info_Model.chaptBrief];
    
    [_newsNotesLabel sizeToFit];
    
    _newsNotesLabel.frame = CGRectMake(10, _lineImageView.frame.origin.y + _lineImageView.frame.size.height + 20, screen_Width-20, _newsNotesLabel.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _newsNotesLabel.frame.origin.y + _newsNotesLabel.frame.size.height);
    
}

@end
