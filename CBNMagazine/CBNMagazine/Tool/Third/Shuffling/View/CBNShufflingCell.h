//
//  CBNShufflingCell.h
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNImageView.h"
#import "CBNShufflingModel.h"
@interface CBNShufflingCell : CBNImageView
@property (nonatomic, strong) CBNLabel *newsTitleLabel;
@property (nonatomic, strong) CBNShufflingModel *shufflingModel;
- (id)initWithFrame:(CGRect)frame andDefaultImage:(UIImage *)defaultImage;
@property (nonatomic, strong) UIImageView *maskImageView;

@end
