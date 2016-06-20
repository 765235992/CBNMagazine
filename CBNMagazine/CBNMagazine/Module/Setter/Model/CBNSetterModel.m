//
//  CBNSetterModel.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNSetterModel.h"

@implementation CBNSetterModel
- (id)initWithResult:(NSDictionary *)result
{
    self = [super init];
    
    if (self) {
        
        
        [self setValuesForKeysWithDictionary:result];
    }
    
    return self;
    
}
@end
