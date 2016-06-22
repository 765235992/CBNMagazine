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


@end

@implementation CBNProjectBaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat startX = 10;
        
        CGFloat startY = 5;
        
        CGFloat cgStartY = 13;
        
        //背景
        UIView * bgV = [[UIView alloc] initWithFrame:CGRectMake(0, cgStartY, screen_Width, self.height - cgStartY * 2)];
        
        bgV.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bgV];
        
        UIImageView * seeImage = [[UIImageView alloc] initWithFrame:CGRectMake(startX,startY + 5, 25, 20)];
        
        seeImage.image = [UIImage imageNamed:@"message_Visitor"];
        
        [bgV addSubview:seeImage];
        
        //标题
        UILabel * titleL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxY(seeImage.frame) +10, startY, screen_Width, 30)];
        
        titleL.text = @"我的访客";
        
        titleL.font = font_px_Medium(16);
        
        [bgV addSubview:titleL];
        [self addSubview:self.aCollectionView];
        [self.aCollectionView registerClass:[CBNProjectCell class] forCellWithReuseIdentifier:@"CBNProjectCell"];

        
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
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CBNProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CBNProjectCell" forIndexPath:indexPath];
//    cell.label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.projectCellClicked!=nil) {
        self.projectCellClicked(indexPath,nil);
        
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
                UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(scrollView.width - 20, scrollView.y + scrollView.height/2 - 10, 20, 20)];
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
    
    
    
//    self.visitorPage ++;
//    NSDictionary*parameters=@{@"uuid":[CurrentUserModel sharedCurrentUserModel].uuid,@"page":@(self.visitorPage),@"pageSize":@(10)};
//    [ONHttpTool POST2:queryVisitorRecordList parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                self.aCollectionView.x = 0;

                
            }];
            [self.indicatorView stopAnimating];
        });
//
//        
//        NSInteger result = [responseObject[@"result"] integerValue];
//        if (result == SUCCESS) {
//            NSArray *visitorArray = responseObject[@"visitorRecordArray"];
//            NSMutableArray *arrar = [NSMutableArray arrayWithArray:self.visitorRecordArray];
//            [visitorArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                
//                VisitorRecordModel *userModel = [VisitorRecordModel userInfoWithDictionary:obj];
//                [arrar addObject:userModel];
//                
//            }];
//            self.visitorRecordArray = arrar;
//            [self.collectionView reloadData];
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        self.collectionView.x = 0;
//        [self.indicatorView stopAnimating];
//        [YWProgressHUD showError:@"系统繁忙"];
//        
//    }];
    
}

@end
