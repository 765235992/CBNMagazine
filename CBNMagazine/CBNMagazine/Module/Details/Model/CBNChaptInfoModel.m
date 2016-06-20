//
//  CBNChaptInfoModel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptInfoModel.h"

@implementation CBNChaptInfoModel
/*
 *  初始化
 */
- (id)initWithChaptInfoResult:(NSDictionary *)chaptInfoResult
{
    self = [super init];
    
    if (self) {
        /*
         *  期刊ID
         */
        self.issueID = [[chaptInfoResult objectForKey:@"issue_id"] integerValue];
        
        /*
         *  文章ID
         */
        self.chaptID = [[chaptInfoResult objectForKey:@"chapt_id"] integerValue];
        
        /*
         *  文章标题
         */
        self.chaptTitle = [chaptInfoResult objectForKey:@"chapt_title"];
        
        /*
         *  文章摘要
         */
        self.chaptBrief = [chaptInfoResult objectForKey:@"chapt_brief"];
        
        /*
         *  文章标签名字
         */
        self.categoryName = [chaptInfoResult objectForKey:@"category_name"];
        
        /*
         *  文章是否有图片
         */
        self.isHavePic = [[chaptInfoResult objectForKey:@"if_pic"] boolValue];
        
        /*
         *  文章图片地址
         */
        self.chaptPicURL = [chaptInfoResult objectForKey:@"chapt_pic_url"];
        
    }
    
    return self;
}
- (void)dealloc
{
    NSLog(@"释放 -- %@",self);
}
@end
