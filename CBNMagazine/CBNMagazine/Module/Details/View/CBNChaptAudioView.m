//
//  CBNChaptAudioView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptAudioView.h"

@interface CBNChaptAudioView ()
@property (nonatomic, strong) CBNLabel *audioTitleLabel;

@property (nonatomic, strong) CBNLabel *columnLabel;

@property (nonatomic, strong) CBNLabel *timeLabel;

@property (nonatomic, strong) UIButton *playButton;
@end

@implementation CBNChaptAudioView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.playButton];

        [self addSubview:self.audioTitleLabel];
        
        [self addSubview:self.columnLabel];
        
        
        self.layer.borderWidth = 1.0f;
        
        self.layer.borderColor = UIColorFromRGB(0xBABABA).CGColor;
        
        self.layer.masksToBounds = YES;
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _audioTitleLabel.frame.size.height + _columnLabel.frame.size.height + 7);
        
        _playButton.center = CGPointMake(_playButton.center.x, self.frame.size.height/2);
        
        _timeLabel.center = CGPointMake(_timeLabel.center.x, self.frame.size.height/2);

        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _playButton.frame = CGRectMake(12, 0, 20, 20);
        
        _playButton.backgroundColor = [UIColor redColor];
    }
    
    return _playButton;
}
- (CBNLabel *)audioTitleLabel
{
    if (!_audioTitleLabel) {
        
        self.audioTitleLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(_playButton.frame.origin.x + _playButton.frame.size.width + 10, 3, screen_Width - (_playButton.frame.origin.x + _playButton.frame.size.width + 10) - (_timeLabel.frame.size.width + 22), 0)];
        _audioTitleLabel.dk_textColorPicker = DKColorPickerWithKey(默认大标题字体颜色);
        
        _audioTitleLabel.font = font_px(fontSize(36.0,36.0,36.0));
        
        _audioTitleLabel.numberOfLines = 0;
        _audioTitleLabel.text  = @"联系Tech Word 2016主题演讲";
        
        [_audioTitleLabel sizeToFit];
        
        _audioTitleLabel.frame = CGRectMake(_playButton.frame.origin.x + _playButton.frame.size.width + 10, 3, self.frame.size.width - (_playButton.frame.origin.x + _playButton.frame.size.width + 10) - (_timeLabel.frame.size.width + 22), _audioTitleLabel.frame.size.height);
        
        
        _audioTitleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _audioTitleLabel;
}

- (CBNLabel *)columnLabel
{
    if (!_columnLabel) {
        
        self.columnLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(_playButton.frame.origin.x + _playButton.frame.size.width + 10, _audioTitleLabel.frame.size.height + 4, screen_Width - (_playButton.frame.origin.x + _playButton.frame.size.width + 10) - (_timeLabel.frame.size.width + 22), 0)];
        
        _columnLabel.dk_textColorPicker = DKColorPickerWithKey(默认标签字体颜色);
        
        _columnLabel.font = font_px(fontSize(32.0,32.0,32.0));
        
        _columnLabel.numberOfLines = 0;

        _columnLabel.text  = @"栏目名称";
        
        [_columnLabel sizeToFit];
        
        
    }
    
    return _columnLabel;
}
- (CBNLabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[CBNLabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(默认大标题字体颜色);
        
        _timeLabel.font = font_px(fontSize(36.0,32.0,32.0));
        
        _timeLabel.numberOfLines = 0;

        _timeLabel.text  = @"59 : 59";
        
        [_timeLabel sizeToFit];
        
        _timeLabel.frame = CGRectMake(self.frame.size.width - 10 - _timeLabel.frame.size.width, 0, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
        
        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _timeLabel;
}







@end
