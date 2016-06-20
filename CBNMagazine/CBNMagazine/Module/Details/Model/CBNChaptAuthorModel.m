//
//  CBNChaptAuthorModel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptAuthorModel.h"

@implementation CBNChaptAuthorModel
/*
 *  初始化
 */
- (id)initWithAuthorResult:(NSDictionary *)authorResult
{
    self = [super init];
    
    if (self) {
        
        /*
         *  作者ID
         */
        self.authorID = [[authorResult objectForKey:@"id"] integerValue];
        
        /*
         *  作者名字
         */
        self.authorName = [authorResult objectForKey:@"reporter_name"];
        
        /*
         *  作者是否为实习
         */
        self.isTrainee = [[authorResult objectForKey:@"is_trainee"] boolValue];
        
        /*
         *  作者简历
         */
        self.authorResume = [authorResult objectForKey:@"resume"];
        
        /*
         *  作者状态
         */
        self.state = [authorResult objectForKey:@"state"];
        
        /*
         *  作者头像
         */
        self.authorImageURL = [authorResult objectForKey:@"cover_url"];
        
    }
    
    return self;
}
- (void)dealloc
{
    NSLog(@"释放 -- %@",self);
}


@end
