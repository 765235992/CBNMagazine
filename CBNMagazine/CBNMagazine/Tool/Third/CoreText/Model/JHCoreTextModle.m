//
//  JHCoreTextModle.m
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "JHCoreTextModle.h"

@implementation JHCoreTextModle

- (id)init {
    self = [super init];
    if (self) {
        _width = 0.0f;
        _fontSize = 14.0f;
        _lineSpace = 5.0f;
        _textColor = 0x000000;
        _fontName = @"PingFangSC-Medium";
        _textAlignment = 0;
        _textAlignment = kCTTextAlignmentLeft;
        
    }
    return self;
}

@end
