//
//  CBNProjectBaseView.m
//  CBNMagazine
//
//  Created by Jim on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNProjectBaseView.h"
#import "CBNProjectLayout.h"
#import "CBNProjectCell.h"
@interface CBNProjectBaseView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *aCollectionView;
/**
 *  旋转图标
 */
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;


@property (nonatomic , assign) NSInteger visitorPage;

@property (nonatomic, strong) NSMutableArray *sourceArray;


@end

@implementation CBNProjectBaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.dk_backgroundColorPicker  = DKColorPickerWithRGB(0xf2f2f2,0xD4D4D4,0xFFFFFF);
 
        [self addSubview:self.aCollectionView];
        
        [self.aCollectionView registerClass:[CBNProjectCell class] forCellWithReuseIdentifier:@"CBNProjectCell"];
        
        [self loadMoreTopic];
        
        
    }
    return self;
}

- (UICollectionView *)aCollectionView
{
    if (!_aCollectionView) {
        CBNProjectLayout* projectLayout = [[CBNProjectLayout alloc] init];

        self.aCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:projectLayout];
        
        _aCollectionView.delegate = self;
        
        _aCollectionView.dataSource = self;
        
        _aCollectionView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xf2f2f2,0xD4D4D4,0xFFFFFF);
        _aCollectionView.showsVerticalScrollIndicator = FALSE;
        _aCollectionView.showsHorizontalScrollIndicator = FALSE;
        
    }
    
    return _aCollectionView;
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.sourceArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CBNProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CBNProjectCell" forIndexPath:indexPath];
    
    cell.projectModel = [_sourceArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.projectCellClicked!=nil) {
        self.projectCellClicked(indexPath,[_sourceArray objectAtIndex:indexPath.row]);
        
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark 访客记录数据加载
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView == self.aCollectionView){
        //检测左测滑动,开始加载更多
        if(scrollView.contentOffset.x +scrollView.width - scrollView.contentSize.width >30){
    
            
            if (self.indicatorView == nil) {
                UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(scrollView.width - 30, scrollView.y + scrollView.height/2 - 10, 20, 20)];
                indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                indicatorView.hidesWhenStopped = YES;
                self.indicatorView = indicatorView;
                [self.indicatorView stopAnimating];
                [scrollView.superview addSubview:self.indicatorView];
                
            }
            if (!self.indicatorView.isAnimating) {
                scrollView.x = -30;
                
                [self.indicatorView startAnimating];
                [self loadMoreTopic];
            }
            
        }
        
    }
}

/**
 *  加载更多专题
 */
- (void)loadMoreTopic {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",sever_URL,Index,GetProjectList];
    NSString *secretStr = [NSString getTheMD5EncryptedStringWithString:[NSString stringWithFormat:@"%@%@",secret_key,GetProjectList]];
    
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    [parDic setObject:secretStr forKey:sever_key_Str];
    
    
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelRequest GET:urlString parameters:parDic success:^(id result) {
        if ([[result objectForKey:@"Code"]integerValue] == 200) {
            for (NSDictionary *dic in [[result objectForKey:@"DataList"] objectForKey:@"data"]) {
                CBNProjectModel *projectModel = [[CBNProjectModel alloc] initWithProjectResult:dic];
                
                [weakSelf.sourceArray addObject:projectModel];

                
            }
            [weakSelf finishedLoading];
            
            
        }
    } failed:^(NSError *error) {

        [weakSelf finishedLoading];

    }];
    


    
}
-(void)finishedLoading
{
    __weak typeof(self) weakSelf = self;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.aCollectionView.x = 0;
            
            [weakSelf.indicatorView stopAnimating];
            
            [weakSelf.aCollectionView reloadData];
            
        }];
    
    });
}
- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
    }
    
    return _sourceArray;
}

@end
