//
//  JHCTFrameAssembleParser.m
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//
//CGAffineTransform matrix =  CGAffineTransformMake(1, 0, tanf(30 * (CGFloat)M_PI / 180), 1, 0, 0);
//
//UIFontDescriptor *desc = [ UIFontDescriptor fontDescriptorWithName :[ UIFont systemFontOfSize :17 ]. fontName matrix :matrix];
//
//UIFont * font = [ UIFont fontWithDescriptor :desc size :17];
//[dict setObject:(id)font forKey:(id)kCTFontAttributeName];

#import "JHCTFrameAssembleParser.h"

@implementation JHCTFrameAssembleParser


/*
 *  根据要求进行配置
 *
 *  requirementsArray 要求列表
 *
 *  styleConfiguration 样式信息
 *
 */
+ (JHCoreTextData *)assembleDataOnRequestWithRequirements:(NSArray *)requirementsArray
{
    NSMutableArray *buttonArray = [NSMutableArray array];

    /*
     *  配置结果
     */
    NSAttributedString *attributedStrResult = [self loadContentWithRequirements:requirementsArray buttonArray:buttonArray];
    
    JHCoreTextData *coreTextData = [self parseAttributedContent:attributedStrResult coreTextModle:[requirementsArray firstObject]];
    
    coreTextData.buttonArray = buttonArray;
    
    return coreTextData;
}

/*
 *  根据要求列表和配置信息进行一项一项的配置
 */

+ (NSAttributedString *)loadContentWithRequirements:(NSArray *)requirementsArray
                                          buttonArray:(NSMutableArray *)buttonArray
{
    //用来装结果
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];

    if (requirementsArray) {
        
        for (JHCoreTextModle *coreTextModle in requirementsArray) {
            
            NSUInteger startPos = result.length;

            NSAttributedString *textAttrResult = [[NSAttributedString alloc] initWithString:coreTextModle.text attributes: [self attributesWithCoreTextModle:coreTextModle]];
            
            [result appendAttributedString:textAttrResult];

            if (coreTextModle.modleType == JHCoreTextModleButtonType) {
                NSUInteger length = result.length - startPos;
                NSRange linkRange = NSMakeRange(startPos, length);
                JHCoreTextButtonData *buttonData = [[JHCoreTextButtonData alloc] init];
                buttonData.coreTextModel = coreTextModle;
                buttonData.range = linkRange;
                [buttonArray addObject:buttonData];

            }
        }
    }
    return result;

}


+ (NSMutableDictionary *)attributesWithCoreTextModle:(JHCoreTextModle *)coreTextModle
{
    CGFloat fontSize = coreTextModle.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)coreTextModle.fontName, fontSize, NULL);
    CGFloat lineSpacing = coreTextModle.lineSpace;
    const CFIndex kNumberOfSettings = 5;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;//kCTLineBreakByCharWrapping;//换行模式
    CTTextAlignment alignment = kCTTextAlignmentLeft;

    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment },
        { kCTParagraphStyleSpecifierLineBreakMode, sizeof(lineBreak), &lineBreak }
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor * textColor = UIColorFromRGB(coreTextModle.textColor);
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
}


+ (JHCoreTextData *)parseAttributedContent:(NSAttributedString *)content
                             coreTextModle:(JHCoreTextModle *)coreTextModle
{
    // 创建CTFramesetterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    // 获得要缓制的区域的高度
    CGSize restrictSize = CGSizeMake(coreTextModle.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    // 生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter coreTextModle:coreTextModle height:textHeight];
    
    // 将生成好的CTFrameRef实例和计算好的缓制高度保存到CoreTextData实例中，最后返回CoreTextData实例
    JHCoreTextData *data = [[JHCoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    data.content = content;
    
    // 释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}

+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                           coreTextModle:(JHCoreTextModle *)coreTextModle
                                  height:(CGFloat)height
{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, coreTextModle.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}






















@end
