//
//  CBNShufflingModel.h
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNShufflingModel : NSObject
@property (nonatomic, strong) NSString *newsTitleStr;

@property (nonatomic, strong) UIImage *newsDefaultImage;

@property (nonatomic, strong) NSString *newsThumbStr;

@property (nonatomic, assign) NSInteger index;
@end
