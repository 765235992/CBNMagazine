//
//  CBNArticleHeaderNormalView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNArticleHeaderNormalView.h"

@interface CBNArticleHeaderNormalView ()
@property (nonatomic, strong) NSMutableArray *authorArray;
@end

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
        
        _newsTitleLabel.lineSpace = 5;
        
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
        
        _newsTitleLabel.font = font_px_Medium(fontSize(56.0,52.0,48.0));
        
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
        
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(白色背景上的默认标签字体颜色);
        
        _timeLabel.font = font_px_Medium(fontSize(42.0,36.0,36.0));
    }
    
    return _timeLabel;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(新闻列表分割线颜色);
        
    }
    
    return _lineImageView;
}

- (CBNLabel *)newsNotesLabel
{
    if (!_newsNotesLabel) {
        
        self.newsNotesLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(10, 0, screen_Width-20, 0)];
        
        _newsNotesLabel.lineSpace = 5;
        
        _newsNotesLabel.dk_textColorPicker = DKColorPickerWithKey(白色背景上的默认标签字体颜色);
        _newsNotesLabel.font = font_px_Regular(fontSize(42.0,36.0,36.0));
        
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
- (NSMutableArray *)authorArray
{
    if (!_authorArray) {
        
        self.authorArray = [[NSMutableArray alloc] init];
    }
    return _authorArray;
}
- (void)setAuthor_List:(NSArray *)author_List
{
    NSLog(@"%@",_chapt_Info_Model.chaptPicURL);
    
    [_newsThumbImageView sd_setImageWithURL:[NSURL URLWithString:_chapt_Info_Model.chaptPicURL] placeholderImage:[UIImage imageNamed:@"defaultImage.jpg"]];
    
    [self.authorArray removeAllObjects];

    if (author_List.count > 0) {
        
        [self.authorArray addObject:[self noClickedDicWithText:@"作者："]];

        
        for (int i = 0; i < author_List.count; i++) {
            if (i%2 ==1) {
               
                [self.authorArray addObject:[self noClickedDicWithText:@" | "]];
            }
            
            CBNChaptAuthorModel *authorModel = [author_List objectAtIndex:i];
            
         
            [self.authorArray addObject:[self canClickedDicWithText:authorModel.authorName]];
        }
       
    }else{
        
        [self.authorArray addObject:[self noClickedDicWithText:@"第一财经周刊"]];
    }
    
    
    CGFloat titleHeight = _newsTitleLabel.frame.size.height + _newsTitleLabel.frame.origin.y + 20;
    
    _timeLabel.text = [NSDate getUTCFormateDate:_chapt_Info_Model.chaptTime];
    
    [_timeLabel sizeToFit];

    _timeLabel.frame = CGRectMake(screen_Width - 10 - _timeLabel.frame.size.width, titleHeight , _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    
    _authorLabel.sourceArray = self.authorArray;
    
    _authorLabel.frame = CGRectMake(10, titleHeight , self.frame.size.width - 30 - _timeLabel.frame.size.width, _authorLabel.frame.size.height);
    
    _authorLabel.backgroundColor = [UIColor clearColor];
    
    
    _lineImageView.frame = CGRectMake(0, _authorLabel.frame.origin.y + _authorLabel.frame.size.height + 20, screen_Width, 1);
    
    
    _newsNotesLabel.content = _chapt_Info_Model.chaptBrief;
    
    [_newsNotesLabel sizeToFit];
    
    _newsNotesLabel.frame = CGRectMake(10, _lineImageView.frame.origin.y + _lineImageView.frame.size.height + 20, screen_Width-20, _newsNotesLabel.frame.size.height);
    
    _audioView.frame = CGRectMake(10, _newsNotesLabel.frame.size.height + _newsNotesLabel.frame.origin.y + 10, screen_Width-20, _audioView.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _audioView.frame.origin.y + _audioView.frame.size.height);
    
}
- (NSDictionary *)canClickedDicWithText:(NSString *)text
{
    NSNumber *authorSize  = [NSNumber numberWithInt:fontSize(36.0,36.0,36.0)];
    NSNumber *authorColor = [NSNumber numberWithInt:0x515151];
    NSNumber *canClicked = [NSNumber numberWithInt:JHCoreTextModleButtonType];
    NSDictionary *tempAuthotDic = [[NSMutableDictionary alloc] init];
    [tempAuthotDic setValue:@"200" forKey:@"width"];
    [tempAuthotDic setValue:authorSize forKey:@"fontSize"];
    [tempAuthotDic setValue:authorColor forKey:@"textColor"];
    [tempAuthotDic setValue:canClicked forKey:@"modleType"];
    [tempAuthotDic setValue:text forKey:@"text"];
    
    return tempAuthotDic;
}
- (NSDictionary *)noClickedDicWithText:(NSString *)text
{
    NSNumber *authorSize  = [NSNumber numberWithInt:fontSize(36.0,36.0,36.0)];
    NSNumber *authorColor = [NSNumber numberWithInt:0x515151];
    NSNumber *noClicked = [NSNumber numberWithInt:JHCoreTextModleTextType];
    NSDictionary *tempAuthotDic = [[NSMutableDictionary alloc] init];
    [tempAuthotDic setValue:@"200" forKey:@"width"];
    [tempAuthotDic setValue:authorSize forKey:@"fontSize"];
    [tempAuthotDic setValue:authorColor forKey:@"textColor"];
    [tempAuthotDic setValue:noClicked forKey:@"modleType"];
    [tempAuthotDic setValue:text forKey:@"text"];
    
    return tempAuthotDic;
}
@end
