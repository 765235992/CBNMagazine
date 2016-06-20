//
//  CBNSegmentView.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNSegmentModel.h"
@interface CBNSegmentView : UIView
@property (nonatomic, copy) void(^channelChanged)(CBNSegmentModel *channelItem);

- (instancetype)initWithFrame:(CGRect)frame andTitleItemArray:(NSArray *)titleItemArray;

@end
