//
//  CBNNetworkStateManager.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNNetworkStateManager : AFHTTPSessionManager
@property (nonatomic, assign) BOOL netWorkState;
+ (instancetype)sharedClient;

- (BOOL)currentNetworkCanDoSomeing;
@end
