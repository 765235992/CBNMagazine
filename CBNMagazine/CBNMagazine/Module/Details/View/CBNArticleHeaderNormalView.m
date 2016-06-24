//
//  CBNArticleHeaderNormalView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNArticleHeaderNormalView.h"
#define clearance_Left_Right 20*screen_Width/320
#define clearance_Top_Bottom 5
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
        
        self.newsTitleLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(10, _newsThumbImageView.frame.size.height +15, screen_Width-clearance_Left_Right*2, 0)];
        _newsTitleLabel.backgroundColor = [UIColor clearColor];
        
        _newsTitleLabel.lineSpace = 5;
        
        _newsTitleLabel.textAlignment = NSTextAlignmentCenter;
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
        
        _newsTitleLabel.font = font_px_Medium(fontSize(56.0,52.0,48.0));
        
    }
    
    return _newsTitleLabel;
}


- (JHCTLabel *)authorLabel
{
    if (!_authorLabel) {
        
        self.authorLabel = [[JHCTLabel alloc] initWithFrame:CGRectMake(10, 100, screen_Width-clearance_Left_Right*2,100)];
        
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
        
        self.newsNotesLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(10, 0, screen_Width-clearance_Left_Right*2, 0)];
        
        _newsNotesLabel.lineSpace = 5;
        
        _newsNotesLabel.textAlignment = NSTextAlignmentCenter;

        _newsNotesLabel.dk_textColorPicker = DKColorPickerWithKey(白色背景上的默认标签字体颜色);
        _newsNotesLabel.font = font_px_Regular(fontSize(42.0,36.0,36.0));
        
    }
    
    return _newsNotesLabel;
}
- (CBNChaptAudioView *)audioView
{
    if (!_audioView) {
        
        self.audioView = [[CBNChaptAudioView alloc] initWithFrame:CGRectMake(clearance_Left_Right, _timeLabel.frame.size.height + _timeLabel.frame.origin.y + clearance_Top_Bottom*2, screen_Width-clearance_Left_Right*2, _audioView.frame.size.height)];
        

    }
    
    return _audioView;
}
- (void)setChapt_Info_Model:(CBNChaptInfoModel *)chapt_Info_Model
{
    
    [_newsThumbImageView sd_setImageWithURL:[NSURL URLWithString:_chapt_Info_Model.chaptPicURL] placeholderImage:[UIImage imageNamed:@"defaultImage.jpg"]];

    
    _chapt_Info_Model = chapt_Info_Model;
    
    self.newsTitleLabel.content = chapt_Info_Model.chaptTitle;
    
    [_newsTitleLabel sizeToFit];
    
    _newsTitleLabel.frame = CGRectMake(clearance_Left_Right, _newsThumbImageView.frame.size.height + clearance_Top_Bottom*3, screen_Width - clearance_Left_Right*2, _newsTitleLabel.frame.size.height);
    
    _newsNotesLabel.content = _chapt_Info_Model.chaptBrief;
    
    [_newsNotesLabel sizeToFit];
    
    _newsNotesLabel.frame = CGRectMake(clearance_Left_Right, _newsTitleLabel.frame.origin.y + _newsTitleLabel.frame.size.height + clearance_Top_Bottom*3, screen_Width-clearance_Left_Right*2, _newsNotesLabel.frame.size.height);
    
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
    
    

    
    
    [self.authorArray removeAllObjects];

    if (author_List.count > 0) {
        
        [self.authorArray addObject:[self noClickedDicWithText:@"作者 | "]];

        
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
    
    CGFloat notesHeight = _newsNotesLabel.frame.size.height + _newsNotesLabel.frame.origin.y + clearance_Top_Bottom*3;
    
    _authorLabel.sourceArray = self.authorArray;
    
    _authorLabel.frame = CGRectMake(clearance_Left_Right, notesHeight , _authorLabel.frame.size.width, _authorLabel.frame.size.height);
    
    _authorLabel.backgroundColor = [UIColor clearColor];
    
    _authorLabel.center = CGPointMake(screen_Width/2, _authorLabel.center.y);
    
    _timeLabel.text = [NSDate getUTCFormateDate:_chapt_Info_Model.chaptTime];
    
    [_timeLabel sizeToFit];
    notesHeight = notesHeight + _authorLabel.frame.size.height + 5;
    
    _timeLabel.frame = CGRectMake(0, notesHeight , _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    
    _timeLabel.center = CGPointMake(screen_Width/2, _timeLabel.center.y);
    
    _audioView.frame = CGRectMake(clearance_Left_Right, _timeLabel.frame.size.height + _timeLabel.frame.origin.y + clearance_Top_Bottom*2, screen_Width-clearance_Left_Right*2, _audioView.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _audioView.frame.origin.y + _audioView.frame.size.height);
    
}
- (NSDictionary *)canClickedDicWithText:(NSString *)text
{
    
    CGFloat width = screen_Width-clearance_Left_Right*2;
    ;
    NSNumber *authorSize  = [NSNumber numberWithInt:fontSize(36.0,36.0,36.0)];
    
    NSNumber *authorColor = [NSNumber numberWithInt:0x515151];
    
    NSNumber *canClicked = [NSNumber numberWithInt:JHCoreTextModleButtonType];
    
    NSDictionary *tempAuthotDic = [[NSMutableDictionary alloc] init];
    [tempAuthotDic setValue:[NSNumber numberWithInteger:1] forKey:@"textAlignment"];

    [tempAuthotDic setValue:[NSString stringWithFormat:@"%f",width]  forKey:@"width"];
    
    [tempAuthotDic setValue:authorSize forKey:@"fontSize"];
    
    [tempAuthotDic setValue:authorColor forKey:@"textColor"];
    
    [tempAuthotDic setValue:canClicked forKey:@"modleType"];
    
    [tempAuthotDic setValue:text forKey:@"text"];
    
    return tempAuthotDic;
}
- (NSDictionary *)noClickedDicWithText:(NSString *)text
{
    CGFloat width = screen_Width-clearance_Left_Right*2;

    NSNumber *authorSize  = [NSNumber numberWithInt:fontSize(36.0,36.0,36.0)];
    
    NSNumber *authorColor = [NSNumber numberWithInt:0x515151];
    
    NSNumber *noClicked = [NSNumber numberWithInt:JHCoreTextModleTextType];
    
    NSDictionary *tempAuthotDic = [[NSMutableDictionary alloc] init];
    
    [tempAuthotDic setValue:[NSNumber numberWithInteger:1] forKey:@"textAlignment"];

    [tempAuthotDic setValue:[NSString stringWithFormat:@"%f",width]  forKey:@"width"];
    
    [tempAuthotDic setValue:authorSize forKey:@"fontSize"];
    
    [tempAuthotDic setValue:authorColor forKey:@"textColor"];
    
    [tempAuthotDic setValue:noClicked forKey:@"modleType"];
    
    [tempAuthotDic setValue:text forKey:@"text"];
    
    return tempAuthotDic;
}
@end
