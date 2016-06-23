//
//  CBNChannelRequest.m
//  CBNMagazine
//
//  Created by Jim on 16/6/22.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChannelRequest.h"

@implementation CBNChannelRequest
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id result))sucess failed:(void (^)(NSError *error))failed
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess)
        {
            sucess(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failed)
        {
            failed(error);
        }
        
    }];
    
}
@end
