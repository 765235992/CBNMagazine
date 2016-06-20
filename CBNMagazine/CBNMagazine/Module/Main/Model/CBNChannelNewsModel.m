//
//  CBNChannelNewsModel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChannelNewsModel.h"

@implementation CBNChannelNewsModel
- (id)initWithChannelNewsInfo:(NSDictionary *)channelNewsInfo
{
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:channelNewsInfo];
    }
    
    return self;
}
@end
