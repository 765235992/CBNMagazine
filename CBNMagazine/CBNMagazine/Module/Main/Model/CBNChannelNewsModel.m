//
//  CBNChannelNewsModel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChannelNewsModel.h"

@implementation CBNChannelNewsModel
- (id)initWithChannelNewsInfo:(NSDictionary *)channelNewsInfo andType:(NSInteger)type
{
    self = [super init];
    
    if (self) {
        
        self.chatp_id = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"chatp_id"]];
        
        self.issue_id = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"issue_id"]];

        self.chapt_title = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"chapt_title"]];

        self.index_title = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"index_title"]];

        self.renew_time = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"renewtime"]];

        self.chapt_time = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"chapt_time"]];

        self.click_count = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"click_count"]];

        self.cover_img_big = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"cover_img_big"]];

        self.data_type = [NSString stringWithFormat:@"%ld",type];

        self.release_time = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"ReleaseTime"]];

        self.sound_time = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"Time"]];

        self.comments = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"Comments"]];

        self.like = [NSString stringWithFormat:@"%@",[channelNewsInfo objectForKey:@"Like"]];

  
    }
    
    return self;
}
- (id)initWithChannelNewsInfo:(NSDictionary *)channelNewsInfo
{
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:channelNewsInfo];
    }
    
    return self;
}
@end
