//
//  CBNLabel.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNLabel.h"

@implementation CBNLabel
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _isCenter = NO;
        
        _lineSpace = 0;

        self.numberOfLines = 0;
        
        
        self.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
        
        
    }
    return self;
}
- (void)setContent:(NSString *)content
{
    if (content == nil || content.length<= 0) {
        
        return;
    }
    _content = content;
    
    
    NSMutableDictionary *attributeDic = [[NSMutableDictionary alloc] init];
    
    /*
     *  段落样式
     */
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    if (self.isCenter == NO) {
        paraStyle.alignment = NSTextAlignmentJustified;

    }else{
        paraStyle.alignment = NSTextAlignmentCenter;

    }
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    [paraStyle setLineSpacing:self.lineSpace];
    
    [attributeDic setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    
    /*
     *  字体 大小
     */
//    [attributeDic setObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    
    self.attributedText = [[NSAttributedString alloc] initWithString:_content attributes: attributeDic];
    
    
}

@end
