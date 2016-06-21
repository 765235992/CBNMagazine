//
//  CBNDetailBottomView.m
//  CBNMagazine
//
//  Created by Jim on 16/6/21.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNDetailBottomView.h"
#import "CBNImageAndTextLabel.h"
#import "CBNCommentesButton.h"

#define item_Height 44

#define item_Width 40

#define item_Interval 5
@interface CBNDetailBottomView ()
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIButton *collectionButton;

@property (nonatomic, strong) UIButton *commentsButton;

@property (nonatomic, strong) CBNImageAndTextLabel *commentsCountLabel;

@property (nonatomic, strong) CBNCommentesButton *sentCommentsButton;
@end

@implementation CBNDetailBottomView

- (void)dealloc
{
    CBNLog(@"文章底部释放");
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.shareButton];
        
        [self addSubview:self.collectionButton];
        
        [self addSubview:self.commentsButton];
        
        self.backgroundColor = UIColorFromRGB(0xF2F2F2);
        
        [self addSubview:self.sentCommentsButton];
//        self addSubview:self
    }
    return self;
}
- (UIButton *)shareButton
{
    if (!_shareButton) {
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _shareButton.frame = CGRectMake(screen_Width - item_Interval - item_Width, 0, item_Width, item_Height);
        
        _shareButton.backgroundColor = [UIColor orangeColor];
    }
    
    return _shareButton;
}

- (UIButton *)collectionButton
{
    if (!_collectionButton) {
        
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _collectionButton.frame = CGRectMake(screen_Width - item_Interval *2 - item_Width * 2, 0, item_Width, item_Height);
        
        _collectionButton.backgroundColor = [UIColor orangeColor];
    }
    
    return _collectionButton;
}
- (UIButton *)commentsButton
{
    if (!_commentsButton) {
        
        self.commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        _commentsButton.backgroundColor = [UIColor orangeColor];
        
        [_commentsButton addSubview:self.commentsCountLabel];
        
        _commentsButton.frame = CGRectMake(screen_Width - item_Interval * 3 - item_Width * 2 - _commentsCountLabel.frame.size.width, 0, _commentsCountLabel.frame.size.width, item_Height);
        
        _commentsCountLabel.center = CGPointMake(_commentsCountLabel.center.x, item_Height/2);
        
    }
    
    return _commentsButton;
}



- (CBNImageAndTextLabel *)commentsCountLabel
{
    if (!_commentsCountLabel) {
        
        self.commentsCountLabel = [[CBNImageAndTextLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) image:[UIImage imageWithColor:RGBColor(172, 108, 148, 1.0)]];
        
        _commentsCountLabel.contentLabel.dk_textColorPicker = DKColorPickerWithKey(默认背景上标签字体颜色);
        
        _commentsCountLabel.iconImageView.dk_imagePicker = DKImagePickerWithImages([UIImage imageNamed:@"commentsCount_white_Day.png"],[UIImage imageNamed:@"commentsCount_white_Day.png"],[UIImage imageNamed:@"commentsCount_white_Day.png"]);
        
        _commentsCountLabel.contentLabel.font = font_px(fontSize(32.0,32.0,32.0));

        _commentsCountLabel.text = @"1042";
        
        _commentsCountLabel.frame = CGRectMake(0, 0, _commentsCountLabel.frame.size.width, _commentsCountLabel.frame.size.height);
    }
    
    return _commentsCountLabel;
}

- (CBNCommentesButton *)sentCommentsButton
{
    if (!_sentCommentsButton) {
        
        self.sentCommentsButton = [[CBNCommentesButton alloc] initWithFrame:CGRectMake(10, 0, (screen_Width  - item_Interval * 6 -item_Width * 2 - _commentsButton.frame.size.width), item_Height)];
        
        _sentCommentsButton.backgroundColor = [UIColor clearColor];
        
        [_sentCommentsButton addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _sentCommentsButton;
}
- (void)sendComment:(id)sender
{
    if (self.aaaaaa!=nil) {
        
        self.aaaaaa(nil);
    }
}















































@end
