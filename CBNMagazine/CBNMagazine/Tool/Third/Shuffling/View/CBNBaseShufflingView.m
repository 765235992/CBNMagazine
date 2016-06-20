//
//  CBNBaseShufflingView.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNBaseShufflingView.h"
#import "CBNShufflingCell.h"

#define myWidth self.frame.size.width
#define myHeight self.frame.size.height
#define pageSize (myHeight * 0.2 > 25 ? 25 : myHeight * 0.2)
#define pageControlHeight 20
@interface CBNBaseShufflingView ()<UIScrollViewDelegate>
{
    
    //当前的下标
    NSInteger _currentIndex;
    
    //轮播内容的最大数量
    NSInteger _MaxshufflingModelsCount;
    
    NSTimer *_timer;
    
}
@property (nonatomic, strong) UIScrollView *aScrollView;

@property (nonatomic, strong) UIImage *defaultImage;

@property (nonatomic, strong) CBNShufflingCell *leftCell;

@property (nonatomic, strong) CBNShufflingCell *centerCell;

@property (nonatomic, strong) CBNShufflingCell *rightCell;

@property (nonatomic, strong) NSArray *newsArray;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic,strong) UIColor *pageIndicatorTintColor;

@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic,assign) PageControlStyle newStyle;

@end

@implementation CBNBaseShufflingView

/*
 首先把轮播初始化出来
 */
- (id)initWithFrame:(CGRect)frame andDefaultImage:(UIImage *)defaultImage
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.defaultImage = defaultImage;
        
        /*
         创建ScrollView
         */
        
        [self addSubview:self.aScrollView];
        
        [self addSubview:self.pageControl];
    }
    
    return self;
}

- (UIScrollView *)aScrollView
{
    if (!_aScrollView) {
        
        self.aScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        _aScrollView.backgroundColor = [UIColor clearColor];
        
        _aScrollView.pagingEnabled = YES;
        
        _aScrollView.showsHorizontalScrollIndicator = NO;
        
        _aScrollView.delegate = self;
        
        _aScrollView.contentSize = CGSizeMake(myWidth * 3,0);
        
        _AutoScrollDelay = 2.0f;
        
        _currentIndex = 0;
        
        _MaxshufflingModelsCount = 3;
        
        [_aScrollView addSubview:self.leftCell];
        
        [_aScrollView addSubview:self.centerCell];
        
        [_aScrollView addSubview:self.rightCell];
        
        
    }
    
    return _aScrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,myHeight - pageControlHeight*1.7,myWidth, pageControlHeight)];
        
        _pageControl.pageIndicatorTintColor = RGBColor(255, 255, 255, 0.3);
        
        _pageControl.currentPageIndicatorTintColor =  [UIColor whiteColor];
        
        _pageControl.numberOfPages = 3;
        
        _pageControl.currentPage = 0;
    }
    
    return _pageControl;
}

/*
 *  指示器风格设置
 */
- (void)setStyle:(PageControlStyle)style
{
    
    self.newStyle = style;
    
    if (_newStyle == PageControlAtRight) {
        
        [self setRightShow];
        
    }
    
    if (_newStyle == PageControlAtLeft) {
        
        [self setLeftShow];
        
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setFont:(UIFont *)font
{
    
    _leftCell.newsTitleLabel.font = font;
    
    _centerCell.newsTitleLabel.font = font;
    
    _rightCell.newsTitleLabel.font = font;
    
}
#pragma mark action事件
- (void)centerCellClicked:(UITapGestureRecognizer *)sender
{
    
    if (self.imageViewDidTapAtIndex != nil) {
        
        self.imageViewDidTapAtIndex([_newsArray objectAtIndex:_currentIndex]);
        
    }
}

//重新设置数量
- (void)setSourceModelArray:(NSArray *)sourceModelArray
{
    
    _MaxshufflingModelsCount = sourceModelArray.count;
    
    _pageControl.numberOfPages = _MaxshufflingModelsCount;
    
    if (_newStyle == PageControlAtRight) {
        
        [self setRightShow];
        
    }
    
    if (_newStyle == PageControlAtLeft) {
        
        [self setLeftShow];
        
    }
    
    self.newsArray = sourceModelArray;
    
    [self changeShufflingModelLeft:_MaxshufflingModelsCount-1 center:0 right:1];
    
}
- (void)setLeftShow
{
    CGFloat w = _MaxshufflingModelsCount * 17.5;
    
    _pageControl.frame = CGRectMake(0, _pageControl.frame.origin.y, w, pageControlHeight);
    
    _pageControl.center = CGPointMake(w*0.5 + 10, _pageControl.center.y);
    
    _leftCell.newsTitleLabel.textAlignment = 0;
    
    _centerCell.newsTitleLabel.textAlignment = 0;
    
    _rightCell.newsTitleLabel.textAlignment = 0;
}
- (void)setRightShow
{
    CGFloat w = _MaxshufflingModelsCount * 17.5;
    
    _pageControl.frame = CGRectMake(0, _pageControl.frame.origin.y, w, pageControlHeight);
    
    _pageControl.center = CGPointMake(myWidth-w*0.5 - 10, _pageControl.center.y);
    
    _leftCell.newsTitleLabel.textAlignment = 2;
    
    _centerCell.newsTitleLabel.textAlignment = 2;
    
    _rightCell.newsTitleLabel.textAlignment = 2;
}

- (void)changeShufflingModelLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex
{
    
    if (_newsArray!= NULL) {
        CBNShufflingModel *leftModel = [_newsArray objectAtIndex:LeftIndex];
        
        CBNShufflingModel *centerModel = [_newsArray objectAtIndex:centerIndex];
        
        CBNShufflingModel *rightModel = [_newsArray objectAtIndex:rightIndex];
        
        _leftCell.shufflingModel = leftModel;
        
        _centerCell.shufflingModel = centerModel;
        
        _rightCell.shufflingModel = rightModel;
    }
    
    
    [_aScrollView setContentOffset:CGPointMake(myWidth, 0)];
    
}


#pragma mark create 创建
- (CBNShufflingCell *)leftCell
{
    if (!_leftCell) {
        
        self.leftCell = [[CBNShufflingCell alloc] initWithFrame:CGRectMake(0, 0,myWidth+1, myHeight) andDefaultImage:_defaultImage];
        
        _leftCell.backgroundColor = [UIColor clearColor];
    }
    
    return _leftCell;
}

- (CBNShufflingCell *)centerCell
{
    if (!_centerCell) {
        
        self.centerCell = [[CBNShufflingCell alloc] initWithFrame:CGRectMake(myWidth, 0,myWidth+1, myHeight) andDefaultImage:_defaultImage];
        
        _centerCell.backgroundColor = [UIColor clearColor];
        
        _centerCell.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerCellClicked:)];
        
        tap.numberOfTapsRequired = 1;
        
        [_centerCell addGestureRecognizer:tap];
    }
    
    return _centerCell;
}
- (CBNShufflingCell *)rightCell
{
    if (!_rightCell) {
        
        self.rightCell = [[CBNShufflingCell alloc] initWithFrame:CGRectMake(myWidth * 2 , 0,myWidth+1, myHeight) andDefaultImage:_defaultImage];
        
        _centerCell.backgroundColor = [UIColor clearColor];
        
    }
    
    return _rightCell;
}



- (void)setAutoScrollDelay:(NSTimeInterval)AutoScrollDelay
{
    _AutoScrollDelay = AutoScrollDelay;
    
    [self removeTimer];
    
    [self setUpTimer];
    
}

- (void)setUpTimer {
    
    if (_AutoScrollDelay < 0.5) return;
    
    _timer = [NSTimer timerWithTimeInterval:_AutoScrollDelay target:self selector:@selector(scorll) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
- (void)scorll
{
    [_aScrollView setContentOffset:CGPointMake(2* myWidth, 0) animated:YES];
    
}

- (void)removeTimer
{
    
    if (_timer == nil) return;
    
    [_timer invalidate];
    
    _timer = nil;
    
}

#pragma mark scrollViewDelegate 代理

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self setUpTimer];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self removeTimer];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self changeImageWithOffset:scrollView.contentOffset.x];
    
}
- (void)changeImageWithOffset:(CGFloat)offsetX {
    
    if (offsetX >= myWidth * 2) {
        
        _currentIndex++;
        
        if (_currentIndex == _MaxshufflingModelsCount-1) {
            
            
            [self changeShufflingModelLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else if (_currentIndex == _MaxshufflingModelsCount) {
            
            _currentIndex = 0;
            
            [self changeShufflingModelLeft:_MaxshufflingModelsCount-1 center:0 right:1];
            
            
        }else {
            
            [self changeShufflingModelLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
            
        }
        
        _pageControl.currentPage = _currentIndex;
        
    }
    
    if (offsetX <= 0) {
        
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeShufflingModelLeft:_MaxshufflingModelsCount-1 center:0 right:1];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _MaxshufflingModelsCount-1;
            
            [self changeShufflingModelLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else {
            
            [self changeShufflingModelLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
            
        }
        
        _pageControl.currentPage = _currentIndex;
    }
    
}







@end
