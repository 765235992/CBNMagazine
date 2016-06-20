//
//  CBNSegmentView.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNSegmentView.h"
#import "CBNSegmentStyle.h"
#import "CBNScrollSegmentView.h"
@interface CBNSegmentView ()
/** 避免循环引用*/
@property (weak, nonatomic) CBNScrollSegmentView *segmentView;
@property (nonatomic, strong) CBNSegmentStyle *style;
@property (strong, nonatomic) NSArray *titlesArray;

@end

@implementation CBNSegmentView

- (instancetype)initWithFrame:(CGRect)frame andTitleItemArray:(NSArray *)titleItemArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.titlesArray = [NSArray arrayWithArray:titleItemArray];
        self.dk_backgroundColorPicker  = DKColorPickerWithKey(频道切换背景颜色);

        // 触发懒加载

        self.style = [[CBNSegmentStyle alloc] init];
        
        _style.showLine = YES;

        _style.segmentHeight = segmentView_Height;
        _style.titleFont = font(14);
        _style.scrollLineHeight = 4;
        [self.segmentView reloadTitlesWithNewTitles:self.titlesArray];

    }
    return self;
}
- (CBNScrollSegmentView *)segmentView {
    if (!_segmentView) {
        __weak typeof(self) weakSelf = self;
        CBNScrollSegmentView *segment = [[CBNScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.style.segmentHeight) segmentStyle:self.style titles:self.titlesArray titleDidClick:^(CBNSegmentModel *segmentItem) {
            if (weakSelf.channelChanged!=nil) {
                weakSelf.channelChanged(segmentItem);
            }
            
        }];
        [self addSubview:segment];
        _segmentView = segment;
    }
    return _segmentView;
}

@end
