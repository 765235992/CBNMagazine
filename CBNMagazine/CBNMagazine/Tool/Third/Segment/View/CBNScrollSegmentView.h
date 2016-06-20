//
//  CBNScrollSegmentView.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNSegmentModel.h"
#import "CBNSegmentStyle.h"

typedef void(^SegmentModelClickedBlock)(CBNSegmentModel *segmentItem);

@interface CBNScrollSegmentView : UIView
@property (strong, nonatomic) UIImage *backgroundImage;

- (instancetype)initWithFrame:(CGRect )frame segmentStyle:(CBNSegmentStyle *)segmentStyle titles:(NSArray *)titles titleDidClick:(SegmentModelClickedBlock)segmentItemClick;
/*
 * 点击按钮的时候调整UI
 */
- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated;
/*
 * 切换下标的时候根据progress同步设置UI
 */
- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex;
/*
 * 让选中的标题居中
 */
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex;
/*
 * 设置选中的下标
 */
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
/*
 * 重新刷新标题的内容
 */
- (void)reloadTitlesWithNewTitles:(NSArray *)titles;

@end
