//
//  CBNArticleModel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBNChaptInfoModel.h"

@interface CBNArticleModel : NSObject
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *if_can_read;
@property (nonatomic, strong) NSString *chapt_id;
@property (nonatomic, strong) CBNChaptInfoModel *chapt_info;
@property (nonatomic, strong) NSMutableArray *author_list;
@property (nonatomic, strong) NSMutableArray *block_list;
@property (nonatomic, strong) NSMutableArray *related_news_list;
- (id)initArticleResult:(NSDictionary *)result;

@end
