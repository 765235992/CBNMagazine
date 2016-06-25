//
//  CBNCommentsEditorView.m
//  CBNMagazine
//
//  Created by Jim on 16/6/21.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNCommentsEditorView.h"

@interface CBNCommentsEditorView ()
@end

@implementation CBNCommentsEditorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textView];
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (UITextView *)textView
{
    if (!_textView) {
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 200, screen_Width, 200)];
        
        _textView.backgroundColor = [UIColor redColor];
    }
    
    return _textView;
}
@end
