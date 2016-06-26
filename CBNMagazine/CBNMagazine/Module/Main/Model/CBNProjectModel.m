//
//  CBNProjectModel.m
//  CBNMagazine
//
//  Created by Jim on 16/6/22.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNProjectModel.h"

@implementation CBNProjectModel
- (id)initWithProjectResult:(NSDictionary *)result
{
    self = [super init];
    
    if (self) {
        self.img = [result objectForKey:@"img"];
        
        self.url = [result objectForKey:@"url"];

    }
    
    return self;
}
@end
