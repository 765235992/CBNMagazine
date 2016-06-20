//
//  CBNBaseShufflingView.h
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNShufflingModel.h"
/*
 轮播指示器风格
 */
typedef NS_ENUM(NSUInteger, PageControlStyle) {
    //中心对齐。默认的
    PageControlAtCenter,
    
    //右边对齐
    PageControlAtRight,
    
    //左侧对齐
    PageControlAtLeft,
};
@interface CBNBaseShufflingView : UIView

/*
 是否允许轮播有标题
 */
@property (nonatomic, assign) BOOL hasTitle;

/*
 默认轮播时间为 2.0f秒,如果小于0.5秒不自动播放
 */
@property (nonatomic,assign) NSTimeInterval AutoScrollDelay;

/*
 轮播指示器风格，默认风格为页面中心
 */
@property (nonatomic,assign) PageControlStyle style;

/*
 font 是每一个轮播图的标题样式
 */
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) NSArray *sourceModelArray;

/*
 LJHShufflingModel 包含以下属性
 @property (nonatomic, strong) NSString *newsTitleStr;
 
 @property (nonatomic, strong) UIImage *newsDefaultImage;
 
 @property (nonatomic, strong) NSString *newsThumbStr;
 
 @property (nonatomic, assign) NSInteger index;
 
 可以通过 setImageViewDidTapAtIndex:^(LJHShufflingModel *shufflingModel) {
 } 来获取轮播图的点击事件，可以通过上述属性来获取轮播图的小标，标题之类的
 */
@property (nonatomic,copy) void(^imageViewDidTapAtIndex)(CBNShufflingModel *shufflingModel);

/*
 首先把轮播初始化出来
 */
- (id)initWithFrame:(CGRect)frame andDefaultImage:(UIImage *)defaultImage;
@end
