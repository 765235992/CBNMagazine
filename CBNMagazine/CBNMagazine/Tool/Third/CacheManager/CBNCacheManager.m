//
//  CBNCacheManager.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/13.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNCacheManager.h"

@implementation CBNCacheManager
/*
 *  使用单利，因为要全局使用
 */
+ (CBNCacheManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    
    static CBNCacheManager *_sharedInstance;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[CBNCacheManager alloc] init];
        
    });
    
    return _sharedInstance;
}
- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}


@end
