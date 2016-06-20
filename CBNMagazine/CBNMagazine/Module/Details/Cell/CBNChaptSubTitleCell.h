//
//  CBNChaptSubTitleCell.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBNChaptBlockModel.h"
#import "CBNChaptBlockTextView.h"

@interface CBNChaptSubTitleCell : UITableViewCell
@property (nonatomic, strong) CBNChaptBlockModel *chaptBlockModel;
@property (nonatomic, strong) CBNChaptBlockTextView *blockTextView;
@end
