//
//  CBNChaptBlockTextView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptBlockTextView.h"
#import "CoreText/CoreText.h"

#define baseColor [UIColor blackColor]

//#define baseFont [UIFont fontWithName:@"Helvetica" size:14]

#define keyWordColor [UIColor orangeColor]

#define readPressColor [UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1]

@interface CBNChaptBlockTextView ()<UITextViewDelegate>
@property (nonatomic, assign) BOOL isKeyWord;
@property (nonatomic, strong) NSMutableDictionary *urlArray;
@property (nonatomic, copy) CBNChaptTextKeyWordClicked aKeyWordClicked;

@property (nonatomic, copy) CBNChaptTextReadPressedAction aReadPressedAction;

@property (nonatomic, copy) CBNChaptTextCancleReadPressedAction aCancleReadPressedAction;

@property (nonatomic, copy) CBNChaptTextCopyAction aCopyAction;

@property (nonatomic, assign) NSInteger readPressIndex;
@end

@implementation CBNChaptBlockTextView
/*
 *  初始化
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.urlArray = [[NSMutableDictionary alloc] init];
        self.scrollEnabled = NO;
        
        self.editable = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.selectable = YES;
        self.delegate = self;
        self.dataDetectorTypes = UIDataDetectorTypeNone;
        /*
         *  给试图添加选择框
         */
        UIMenuItem *menuItem1 = [[UIMenuItem alloc]initWithTitle:@"摘录" action:@selector(readPressed:)];
        
        UIMenuItem *menuItem2 = [[UIMenuItem alloc]initWithTitle:@"取消摘录" action:@selector(cancelReadPressed:)];
        
        UIMenuItem *menuItem3 = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyPressed:)];
        
        NSArray *menuItems = [NSArray arrayWithObjects:menuItem1,menuItem2,menuItem3,nil];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        [menu setMenuItems:menuItems];
    }
    return self;
}
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    self.delegate = self;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}
#pragma mark    -------  整体NSMutableAttributedString配置 -------
/*
 *  整体全部的基本配置
 */
- (NSMutableAttributedString *)basicAttributedStringConfigurationWithText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    /*
     *  整体长度
     */
    NSRange textRange = NSMakeRange(0, text.length);
    
    
    /*
     *  整体基本字体样式
     */
    [attributedString addAttribute:NSFontAttributeName value:self.font range:textRange];
    
    /*
     *  设置段落样式，整行铺满NSTextAlignmentJustified
     */
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init]; paraStyle.alignment = NSTextAlignmentJustified;
    
    paraStyle.lineSpacing = 5;
    
    paraStyle.alignment = NSTextAlignmentJustified;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:textRange];
    
    
    return attributedString;
}
/*
 *  关键字配置
 */
- (NSMutableAttributedString *)keyWordAttributedStringConfigurationWithKeyWordArray:(NSArray *)keyWordArray andAttributedString:(NSMutableAttributedString *)attributedString andText:(NSString *)text
{
    NSMutableAttributedString *newAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    
    /*
     *  首先判断是否有关键字
     */
    if (keyWordArray.count <=  0) {
        
        return attributedString;
    }
    /*
     *  使用正则表达式进行匹配
     */
    NSString *keyWordStr = [keyWordArray componentsJoinedByString:@"|"];
    
    NSString *mentionPattern = [NSString stringWithFormat: @"(%@)",keyWordStr];
    
    NSError *error = NULL;
    
    NSRegularExpression *mentionExpression = [NSRegularExpression regularExpressionWithPattern:mentionPattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRange textRange = NSMakeRange(0, text.length);
    
    [mentionExpression enumerateMatchesInString:text options:NSMatchingReportProgress range:textRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        if (result != NULL) {
            
            /*
             *  匹配出所有的子字符串
             */
            NSRange range = result.range;
            
            NSString *subString = [[NSString stringWithFormat:@"%@",text] substringWithRange:result.range];
            
            for (NSInteger i = range.location; i < range.length+range.location; i++) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                
                NSValue *rangeValue = [NSValue valueWithRange:result.range];
                NSLog(@"%@",rangeValue);
                [dic setObject:rangeValue forKey:subString];
                
                [_urlArray setObject:dic forKey:[NSNumber numberWithInteger:i]];
                
            }
            
            
            
            NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
            
            /*
             *  关键字
             */
            [attributes setObject:subString forKey:NSLinkAttributeName];
            
            [attributes setObject:@"Mention" forKey:@"CustomDetectionType"];
            attributes[(id)kCTForegroundColorAttributeName] = (id)[UIColor blueColor].CGColor;
            
            
            /*
             *  添加链接下划线
             */
            [attributes setObject:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle] forKey:(id)NSUnderlineStyleAttributeName];
            /*
             *  设置关键字的颜色
             */
            /*
             *  添加链接下划线颜色
             */
            [attributes setObject:UIColorFromRGB(0x436EEE) forKey:NSForegroundColorAttributeName];
            //
            [attributes setObject:UIColorFromRGB(0x436EEE) forKey:NSUnderlineColorAttributeName];
            
            
            [newAttributedString addAttributes:attributes range:result.range];
            
            self.linkTextAttributes = attributes;
            
            attributes = nil;
        }
        
        
    }];
    
    return newAttributedString;
    
    
}

- (NSMutableAttributedString *)readPressAttributedStringArray:(NSArray *)readPressArray andAttributedString:(NSMutableAttributedString *)attributedString andText:(NSString *)text
{
    NSMutableAttributedString *readPressAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    
    
    for (NSDictionary *dic in readPressArray) {
        /*
         *  设置已经摘录内容的配置
         */
        
        NSMutableDictionary *attributeDic = [[NSMutableDictionary alloc] init];
        
        [attributeDic setObject:readPressColor forKey:NSUnderlineColorAttributeName];
        
        [attributeDic setObject:readPressColor forKey:NSForegroundColorAttributeName];
        
        [attributeDic setObject:@(NSUnderlineStyleSingle) forKey:NSUnderlineStyleAttributeName];
        
        NSInteger location = [[dic objectForKey:@"beginIndex"] integerValue];
        
        NSInteger length = [[dic objectForKey:@"length"] integerValue];
        
        [readPressAttributedString addAttributes:attributeDic range:NSMakeRange(location, length)];
        
    }
    
    return readPressAttributedString;
    
}
- (void)setText:(NSString *)text
{
    /*
     *  基本整体的配置
     */
    NSMutableAttributedString *baseAttributedString = [self basicAttributedStringConfigurationWithText:text];
    
    /*
     *  摘录配置
     */
    NSMutableAttributedString *readPressAttributedString = [self readPressAttributedStringArray:_chaptBlockModel.readPressArray andAttributedString:baseAttributedString andText:text];
    /*
     *  关键字信息配置
     */
    
    NSMutableAttributedString *newAttributedString = [self keyWordAttributedStringConfigurationWithKeyWordArray:_chaptBlockModel.keyWordStrArray andAttributedString:readPressAttributedString andText:text];
    
    self.attributedText = newAttributedString;
    self.dk_textColorPicker = DKColorPickerWithKey(新闻大标题字体颜色);
    
    [self sizeToFit];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y , self.frame.size.width, self.frame.size.height + 10);
    [self setNeedsDisplay];
    [self setNeedsLayout];
    
}
- (void)setChaptBlockModel:(CBNChaptBlockModel *)chaptBlockModel
{
    
    [_urlArray removeAllObjects];
    
    _chaptBlockModel = chaptBlockModel;
    
    self.text = _chaptBlockModel.blockTextContent;
    
}




#pragma mark    -------  UITextViewDelegate -------
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"11111");
    id detectionType = [self.attributedText attribute:@"CustomDetectionType" atIndex:characterRange.location effectiveRange:nil];
    
    if ([detectionType  isEqual: @"Mention"]) {
        
    }else{
        
        return true;
        
    }
    NSString *subString = [self.text substringWithRange:characterRange];
    
    if (subString != nil) {
        /*
         *  如果是关键字，把弹出的视图框，关闭
         */
        if (self.aKeyWordClicked != nil) {
            
            self.aKeyWordClicked([self.chaptBlockModel.keyWordContentDic objectForKey:subString]);
            
        }
        
        return NO;
        
    }
    
    return true;
}
/*
 *  手势辨别
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    [super gestureRecognizerShouldBegin:gestureRecognizer];
    
    
    if ([[gestureRecognizer class] isSubclassOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
        
        
        if (tap.numberOfTapsRequired == 2) {
            
            return NO;
        }
    }
    
    return YES;
}
#pragma mark    -------  action 事件 -------
/*
 *  是否已经添加的摘录
 */
- (BOOL)isHasRead
{
    /*
     *  当前开始位置
     */
    NSInteger currentLocation = self.selectedRange.location;
    /*
     *  选择的长度
     */
    NSInteger currentLength = self.selectedRange.length;
    
    /*
     *  结束位置
     */
    NSInteger currentEnd = currentLocation + currentLength;
    
    /*
     *  摘录数量
     */
    NSInteger readPressCount = [_chaptBlockModel.readPressArray count];
    
    
    if (readPressCount > 0)
    {
        /*
         *  摘录数量大于0，说明已经有摘录了
         *  有摘录，就需要把所有摘录进行遍历循环一下，看看当前的摘录是否已经包含在已经摘录的内容里面
         */
        
        self.readPressIndex = 0;
        
        NSDictionary *tempDic;
        
        for (tempDic in _chaptBlockModel.readPressArray)
        {
            self.readPressIndex++;
            
            /*
             *  偏移位置
             */
            NSInteger location = [[tempDic objectForKey:@"beginIndex"] integerValue];
            
            /*
             *  摘录长度
             */
            NSInteger length = [[tempDic objectForKey:@"length"] integerValue];
            
            /*
             *  结束位置
             */
            NSInteger end = location + length;
            
            if ((currentLocation >= location) && (currentEnd <= end))
            {
                /*
                 *  如果当前开始位置 大于或者等于 已摘录的开始位置
                 *
                 *  并且，当前结束位置 小于或者等于 已摘录的结束位置
                 *
                 *  说明，摘录内容包含了已经被摘录过的内容
                 */
                
                return TRUE;
                
            }else if ((currentLocation >= location) && (currentLocation < end))
            {
                
                /*
                 *  如果当前开始位置 大于或者等于 已摘录的开始位置
                 *
                 *  并且，当前开始位置 小于 已摘录的结束位置
                 *
                 *  说明，摘录内容在已经摘录的内容里面，
                 */
                
                
                return TRUE;
            }else if ((currentEnd > location) && (currentEnd <= end))
            {
                
                /*
                 *  如果当前结束位置 大于 已摘录的开始位置
                 *
                 *  并且，当前结束位置 小于 已摘录的结束位置
                 *
                 *  说明，摘录内容在已经摘录的内容里面，
                 */
                
                return TRUE;
            }else if ((currentLocation <= location) && (currentEnd >= end))
            {
                /*
                 *  如果当前结束位置 大于 已摘录的开始位置
                 *
                 *  并且，当前结束位置 小于 已摘录的结束位置
                 *
                 *  说明，摘录内容在已经摘录的内容里面，
                 */
                
                return TRUE;
            }
        }
        return FALSE;
    }
    else
    {
        /*
         *  没有摘录，返回false
         */
        return FALSE;
    }
    
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    
    if ([self isHasRead] == TRUE)
    {
        if (action == @selector(cancelReadPressed:) || action == @selector(copyPressed:))
        {
            return YES;
        }
    }
    else
    {
        if (action == @selector(readPressed:) || action == @selector(copyPressed:))
        {
            return YES;
        }
    }
    if (action == @selector(copy:)) {
        
        // 菜单不能响应copy项
        return NO;
    }
    return NO; //隐藏系统默认的菜单项
}

/*
 *  摘录
 */
- (void)readPressed:(id)sender
{
    
    [UIMenuController sharedMenuController].menuVisible = NO;
    
    if (self.aReadPressedAction != nil) {
        
        CBNChaptBlockModel *tempModel = self.chaptBlockModel;
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.chaptBlockModel.readPressArray];
        
        [tempArray addObject:[self selectInfo]];
        
        tempModel.readPressArray = tempArray;
        
        self.chaptBlockModel = tempModel;
        [self selectInfo];
        self.aReadPressedAction([self selectInfo]);
        
        
    }
    [self setNeedsDisplay];
}
/*
 *  取消摘录
 */
- (void)cancelReadPressed:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;
    
    if (self.aCancleReadPressedAction != nil) {
        //
        CBNChaptBlockModel *tempModel = self.chaptBlockModel;
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.chaptBlockModel.readPressArray];
        
        [tempArray removeObjectAtIndex:self.readPressIndex-1];
        
        tempModel.readPressArray = tempArray;
        
        self.chaptBlockModel = tempModel;
        //
        self.aCancleReadPressedAction([self selectInfo]);
        //
        
        
    }
}
/*
 *  复制
 */
- (void)copyPressed:(id)sender
{
    
    if (self.aCopyAction != nil) {
        //
        //        JHParagraphModel *tempModel = self.paragraphModel;
        //
        //        self.paragraphModel = tempModel;
        //
        //        NSString *subString = [self.text substringWithRange:self.selectedRange];
        //
        //        [[UIPasteboard generalPasteboard] setValue:subString forPasteboardType:@"public.utf8-plain-text"];
        //
        //        self.aCopyAction([self selectInfo]);
        
    }
}

- (NSDictionary *)selectInfo
{
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    /*
     *  开始位置，也就是偏移位置
     */
    [info setObject:[NSString stringWithFormat:@"%lu",(unsigned long)self.selectedRange.location] forKey:@"beginIndex"];
    
    /*
     *  截取长度
     */
    [info setObject:[NSString stringWithFormat:@"%lu",(unsigned long)self.selectedRange.length] forKey:@"length"];
    
    /*
     *  段落标记
     */
    [info setObject:[NSString stringWithFormat:@"%ld",(long)_chaptBlockModel.blockID] forKey:@"blockID"];
    
    NSString *subString = [self.text substringWithRange:self.selectedRange];
    
    [info setObject:subString forKey:@"subString"];
    
    return info;
}
/*
 *  关键字点击
 */
- (void)CBNChaptKeyWordClicked:(CBNChaptTextKeyWordClicked)keyWordClicked copyAction:(CBNChaptTextCopyAction)copyAction readPressedAction:(CBNChaptTextReadPressedAction)readPressedAction cancleReadPressedAction:(CBNChaptTextCancleReadPressedAction)cancleReadPressedAction
{
    self.aKeyWordClicked = keyWordClicked;
    
    self.aCopyAction = copyAction;
    
    self.aReadPressedAction = readPressedAction;
    
    self.aCancleReadPressedAction = cancleReadPressedAction;
}

- (void)dealloc
{
    NSLog(@"dealloc -- %@",self);
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    [linkedString] = rangeValue;
    
    NSString *keyWordStr = [self handleTouches:touches];
    
    if (keyWordStr != NULL && self.aKeyWordClicked!=nil ) {
        self.aKeyWordClicked([self.chaptBlockModel.keyWordContentDic objectForKey:keyWordStr]);
    }
}

- (NSString *)handleTouches:(NSSet *)touches
{
    CGPoint location = [touches.allObjects.lastObject locationInView:self];
    location.x -= self.textContainerInset.left;
    location.y -= self.textContainerInset.top;
    
    return [self findLinkedStringAtPoint:location];
}
- (NSString *)findLinkedStringAtPoint:(CGPoint)point
{
    
    NSUInteger characterIndex;
    characterIndex = [self.layoutManager
                      characterIndexForPoint:point
                      inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
    
    __block NSString *result = nil;
    
    NSLog(@"%@",_urlArray);
    
    [[_urlArray objectForKey:[NSNumber numberWithInteger:characterIndex]] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSValue *value = (NSValue *)obj;
        NSRange rangeToCheck = [value rangeValue];
        NSUInteger min = rangeToCheck.location;
        NSUInteger max = min + rangeToCheck.length;
        NSLog(@"%@",value);
        if (characterIndex >= min && characterIndex < max){
            
            result = key;
            *stop = YES;
        }
        
    }];
    NSLog(@"%@",result);
    
    
    return result;
    
}

@end
