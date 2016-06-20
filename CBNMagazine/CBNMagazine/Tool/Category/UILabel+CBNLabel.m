//
//  UILabel+CBNLabel.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/13.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "UILabel+CBNLabel.h"

@implementation UILabel (CBNLabel)
/*
 *  设置大标题
 */
- (NSAttributedString *)titleLabelAttributedStringWithString:(NSString *)string
{
        
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    /*
     *  设置对齐方式
     */
    paraStyle.alignment = NSTextAlignmentJustified;
    /*
     *  设置行间距
     */
    paraStyle.lineSpacing = 7;
    
    /*
     *  字符换行
     */
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *attrDict = @{NSParagraphStyleAttributeName:paraStyle};
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attrDict];;
    
    return attributedString;
}

@end
