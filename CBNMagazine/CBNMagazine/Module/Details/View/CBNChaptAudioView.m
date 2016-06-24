//
//  CBNChaptAudioView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptAudioView.h"
#import "CBNMarqueeView.h"

#define clearance 7*screen_Width/320

#define text_clearance 2*screen_Width/320

@interface CBNChaptAudioView ()
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat columnHeight;

@property (nonatomic, strong) CBNMarqueeView *audioTitleLabel;

@property (nonatomic, strong) CBNLabel *columnLabel;

@property (nonatomic, strong) CBNLabel *timeLabel;

@property (nonatomic, strong) UIButton *playButton;
@end

@implementation CBNChaptAudioView
- (void)dealloc
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGSize size1 = [@" " sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font_px_Medium(fontSize(46.0,38.0,38.0)),NSFontAttributeName, nil]];
        
        self.titleHeight = size1.height;
        
        CGSize size2 = [@" " sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font_px_Medium(fontSize(32.0,32.0,32.0)),NSFontAttributeName, nil]];

        self.columnHeight = size2.height;

        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, clearance*2 + text_clearance + _titleHeight + _columnHeight);

        self.layer.cornerRadius = self.frame.size.height/2;//设置那个圆角的有多圆
        
        self.dk_backgroundColorPicker = DKColorPickerWithKey(红色背景颜色);
        
        [self addSubview:self.playButton];

        [self addSubview:self.audioTitleLabel];
        
        [self addSubview:self.columnLabel];
        
        [self addSubview:self.timeLabel];

        
        self.layer.masksToBounds = YES;
 
      

    }
    return self;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _playButton.frame = CGRectMake(clearance, clearance, self.frame.size.height - clearance*2, self.frame.size.height - clearance*2);
        
        [_playButton setBackgroundImage:[UIImage imageNamed:@"play_pause_Day.png"] forState:UIControlStateNormal];
        
        _playButton.center = CGPointMake(_playButton.center.x, self.frame.size.height/2);

    }
    
    return _playButton;
}
- (CBNMarqueeView *)audioTitleLabel
{
    if (!_audioTitleLabel) {

        self.audioTitleLabel = [[CBNMarqueeView alloc] initWithFrame:CGRectMake( _playButton.frame.size.width + clearance * 2, clearance , self.frame.size.width - (self.frame.size.height/2 + clearance  + _playButton.frame.size.width), _titleHeight)];

        NSString *text = @"联系Tech Wo联系Tech Worr";
        
        self.audioTitleLabel.text = [self getNewStrWithText:text];

        self.audioTitleLabel.scrollDirection = CBAutoScrollDirectionLeft;
        self.audioTitleLabel.labelSpacing = 0;
        [self.audioTitleLabel observeApplicationNotifications];
        
        _audioTitleLabel.textColor = [UIColor whiteColor];
        
        self.audioTitleLabel.pauseInterval = 0.0;
        
        _audioTitleLabel.font = font_px_Medium(fontSize(42.0,38.0,38.0));
        
        _audioTitleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _audioTitleLabel;
}

- (NSString *)getNewStrWithText:(NSString *)text
{
    CGSize size1 = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font_px_Medium(fontSize(46.0,38.0,38.0)),NSFontAttributeName, nil]];

    
    if (size1.width > _audioTitleLabel.frame.size.width) {
        
        return text;
        
    }
    
    NSMutableArray *strArray = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < ((_audioTitleLabel.frame.size.width - size1.width)/_titleHeight + 1)*2; i++) {
        [strArray addObject:@"  "];
    }
    NSString *ns=[strArray componentsJoinedByString:@""];

    NSString *newStr = [text stringByAppendingFormat:@"%@",ns];
  

    return newStr;
    
}
- (CBNLabel *)columnLabel
{
    if (!_columnLabel) {
        
        self.columnLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(_playButton.frame.origin.x + _playButton.frame.size.width + clearance, _audioTitleLabel.frame.size.height + clearance , screen_Width - (_playButton.frame.origin.x + _playButton.frame.size.width + 10) - (_timeLabel.frame.size.width + 22), 0)];
        
//        _columnLabel.dk_textColorPicker = DKColorPickerWithKey(白色背景上的默认标签字体颜色);
        
        
        _columnLabel.font = font_px_Medium(fontSize(32.0,32.0,32.0));
        
        _columnLabel.numberOfLines = 0;

        _columnLabel.text  = @"栏目名称";
        
        [_columnLabel sizeToFit];
        
        _columnLabel.textColor = [UIColor whiteColor];

    }
    
    return _columnLabel;
}
- (CBNLabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
        
        _timeLabel.textColor = [UIColor whiteColor];
        
        _timeLabel.font = font_px_Medium(fontSize(36.0,32.0,32.0));
        
        _timeLabel.numberOfLines = 0;

        _timeLabel.text  = @"59 : 59";
        
        [_timeLabel sizeToFit];
    
        _timeLabel.frame = CGRectMake( self.frame.size.width - (self.frame.size.height/2 +  _timeLabel.frame.size.width-clearance), _audioTitleLabel.frame.size.height + clearance, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
        
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _timeLabel;
}







@end
