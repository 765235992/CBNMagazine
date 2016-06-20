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

@interface CBNProjectBaseView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *aCollectionView;
@end

@implementation CBNProjectBaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
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
    return 60;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CBNProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CBNProjectCell" forIndexPath:indexPath];
//    cell.label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    return cell;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
