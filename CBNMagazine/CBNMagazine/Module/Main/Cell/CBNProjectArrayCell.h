//
//  CBNProjectArrayCell.h
//  CBNMagazine
//
//  Created by Jim on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNProjectBaseView.h"
#import "CBNChannelNewsModel.h"

@interface CBNProjectArrayCell : UITableViewCell
@property (nonatomic, strong) CBNChannelNewsModel *channelNewsModel;

@property (nonatomic, strong) CBNProjectBaseView *projectCollectionView;

@end
