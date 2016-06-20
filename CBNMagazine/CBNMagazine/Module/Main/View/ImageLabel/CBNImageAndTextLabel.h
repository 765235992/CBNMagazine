//
//  CBNImageAndTextLabel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBNImageAndTextLabel : UIView
@property (nonatomic, strong) CBNLabel *contentLabel;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImageView *iconImageView;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;

@end
