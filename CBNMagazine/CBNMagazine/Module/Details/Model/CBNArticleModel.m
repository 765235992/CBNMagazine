//
//  CBNArticleModel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNArticleModel.h"

#import "CBNChaptAuthorModel.h"
#import "CBNChaptBlockModel.h"

@implementation CBNArticleModel
- (id)initArticleResult:(NSDictionary *)result
{
    self = [super init];
    
    if (self) {
        
        self.result = [NSString stringWithFormat:@"%@",[result objectForKey:@"result"]];
        /*
         *  服务器是否允许刻度
         */
        self.if_can_read = [NSString stringWithFormat:@"%@",[result objectForKey:@"if_can_read"]];
        /*
         *  文章ID
         */
        self.chapt_id = [NSString stringWithFormat:@"%@",[result objectForKey:@"chapt_id"]];
        
        self.author_list = [[NSMutableArray alloc] init];
        
        for (NSDictionary *authorDic in [result objectForKey:@"author_list"]) {
            CBNChaptAuthorModel *authorModel = [[CBNChaptAuthorModel alloc] initWithAuthorResult:authorDic];
            
            [_author_list addObject:authorModel];
            
        }
        
        self.block_list = [[NSMutableArray alloc] init];
        
        for (NSDictionary *blockDic in [result objectForKey:@"block_list"]) {
            
            CBNChaptBlockModel *blockModel = [[CBNChaptBlockModel alloc] initWithBlockResult:blockDic];
            
            [_block_list addObject:blockModel];
            
        }
        self.chapt_info = [[CBNChaptInfoModel alloc] initWithChaptInfoResult:[result objectForKey:@"chapt_info"]];
        
        self.related_news_list = [[NSMutableArray alloc] init];
        
//        for (NSDictionary *relatedNewsDic in [result objectForKey:@"RelatedNews"]) {
//            
//        }
        
        
    }
    
    return self;
    
}

@end
