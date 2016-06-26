//
//  JHCTLabel.m
//  自定义Label
//JHCoreTextModle *tempModle = [[JHCoreTextModle alloc] init];
//
////        temp[];
//tempModle.width = [[temp objectForKey:@"width"] intValue];
////宽度
//tempModle.fontSize= [[temp objectForKey:@"fontSize"] intValue];
//
////字体大小
//tempModle.fontName= [temp objectForKey:@"fontName"];
//
////字体名字
//tempModle.lineSpace= [[temp objectForKey:@"lineSpace"] intValue];
//
////行间距
//tempModle.textColor= [[temp objectForKey:@"textColor"] intValue];
//
////字体颜色
//tempModle.text= [temp objectForKey:@"text"];
//
////内容
//tempModle.modleType= [[temp objectForKey:@"modleType"] intValue];
//
////内容类型
////tempArray ad
//[tempArray addObject:tempModle];

//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "JHCTLabel.h"
#import "JHCoreTextUtils.h"
#import "JHCoreTextButtonData.h"
#import "JHCTFrameAssembleParser.h"

@interface JHCTLabel ()
@property (strong, nonatomic) JHCoreTextData * data;

@end

@implementation JHCTLabel
- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupEvents];
    }
    return self;
}

- (void)setData:(JHCoreTextData *)data {
    _data = data;
}



- (void)setupEvents {
    /*
     *  给试图添加选择框
     */
    UIGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(userTapGestureDetected:)];
    [self addGestureRecognizer:tapRecognizer];
    
    self.userInteractionEnabled = YES;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.data == nil) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    
    CTFrameDraw(self.data.ctFrame, context);
}

- (void)userTapGestureDetected:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    
    JHCoreTextButtonData *linkData = [JHCoreTextUtils touchButtonInView:self atPoint:point data:self.data];
    if (linkData) {
        if (self.labelClicked != nil) {
            self.labelClicked(linkData.coreTextModel);
        }
        return;
    }
}

- (void)setSourceArray:(NSArray *)sourceArray
{
    _sourceArray = sourceArray;

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *temp in sourceArray) {
        JHCoreTextModle *tempModle = [[JHCoreTextModle alloc] init];
        
        NSEnumerator *enumerator = [temp keyEnumerator];
        
        id key = [enumerator nextObject];
        
        while (key) {
            
            id obj = [temp objectForKey:key];
            
            [tempModle setValue:obj forKey:key];
            
            key = [enumerator nextObject];
            
        }
        
        [tempArray addObject:tempModle];

    }
    
    self.data = [JHCTFrameAssembleParser assembleDataOnRequestWithRequirements:tempArray];
    
    self.height = _data.height;
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)dealloc
{
    NSLog(@"释放了 %@",self);
}
@end
