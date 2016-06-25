//
//  CBNCommentesButton.m
//  CBNMagazine
//
//  Created by Jim on 16/6/21.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNCommentesButton.h"

#define commentes_Button_Height self.frame.size.height - 14
@interface CBNCommentesButton ()

@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) CBNImageView *iconImageView;

@property (nonatomic, strong) CBNLabel *commentTextView;
@end

@implementation CBNCommentesButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
//        [self addSubview:self.view];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}
- (UIView *)view
{
    
    if (!_view) {
        
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 7, self.frame.size.width, commentes_Button_Height)];
//        _view.userInteractionEnabled = NO;
        _view.layer.borderColor = [UIColor grayColor].CGColor;
//
        _view.layer.borderWidth = 1;
        
        _view.layer.cornerRadius = 10;
//        
//        [_view addSubview:self.iconImageView];
//        
//        [_view addSubview:self.commentTextView];
        
    }
    
    return _view;
}

- (CBNImageView *)iconImageView
{
    if (!_iconImageView) {
        
        self.iconImageView = [[CBNImageView alloc] initWithFrame:CGRectMake(8, 6, commentes_Button_Height-12, commentes_Button_Height-12)];
        
        _iconImageView.backgroundColor = [UIColor yellowColor];
        
    }
    
    return _iconImageView;
}

- (CBNLabel *)commentTextView
{
    if (!_commentTextView) {
        
        self.commentTextView = [[CBNLabel alloc] initWithFrame:CGRectMake(_iconImageView.frame.size.width + 12, 0, _view.frame.size.width - (_iconImageView.frame.size.width + 20), commentes_Button_Height)];
        _commentTextView.userInteractionEnabled = NO;
        _commentTextView.textColor = [UIColor grayColor];
        
        _commentTextView.font = font_px_Medium(fontSize(36.0,36.0,36.0));
        
        _commentTextView.text = @"写评论……";

    }
    
    return _commentTextView;
}






@end
