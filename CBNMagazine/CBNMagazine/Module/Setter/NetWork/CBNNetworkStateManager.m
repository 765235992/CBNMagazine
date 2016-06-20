//
//  CBNNetworkStateManager.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNNetworkStateManager.h"

@implementation CBNNetworkStateManager
static NSString * const CBNNetworkStateManagerBaseURLString = @"https://api.app.net/";


+ (instancetype)sharedClient {
    static CBNNetworkStateManager *_sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedClient = [[CBNNetworkStateManager alloc] initWithBaseURL:[NSURL URLWithString:CBNNetworkStateManagerBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G网络");
                    [[CBNFileManager sharedInstance] saveBasicDataTypes:[NSNumber numberWithBool:YES] withKey:@"is3G"];
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"wifi网络");

                    [[CBNFileManager sharedInstance] saveBasicDataTypes:[NSNumber numberWithBool:NO] withKey:@"is3G"];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"无网络");

                    [[CBNFileManager sharedInstance] saveBasicDataTypes:[NSNumber numberWithBool:NO] withKey:@"is3G"];
                    break;
                default:
                    NSLog(@"无网络");

                    [[CBNFileManager sharedInstance] saveBasicDataTypes:[NSNumber numberWithBool:NO] withKey:@"is3G"];

                    break;
            }
        }];
        [_sharedClient.reachabilityManager startMonitoring];
    });
    
    return _sharedClient;
}


- (BOOL)currentNetworkCanDoSomeing
{
    BOOL is3GValue = [[[CBNFileManager sharedInstance] loadBasicDataTypesWithKey:@"is3G"] boolValue];
    
    NSArray *arr = [NSArray arrayWithArray:[[CBNFileManager sharedInstance] loadBasicDataTypesWithKey:@"setter"]];
    
    if (arr.count == 0) {
        
        return YES;
    }
    NSDictionary *wifiDic = [[arr firstObject] objectAtIndex:1];
    
    if ([[wifiDic objectForKey:@"value"] boolValue] == YES && is3GValue == YES) {
        
        return NO;
        
    }
    
    return YES;
}

@end
