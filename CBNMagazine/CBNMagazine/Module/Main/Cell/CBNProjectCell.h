//
//  CBNProjectCell.h
//  CBNMagazine
//
//  Created by Jim on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNProjectModel.h"

@interface CBNProjectCell : UICollectionViewCell
@property (nonatomic, strong) CBNImageView *projectImageView;
@property (nonatomic, strong) CBNProjectModel *projectModel;
@end
