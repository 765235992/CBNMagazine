//
//  CBNChannelRequest.h
//  CBNMagazine
//
//  Created by Jim on 16/6/22.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNChannelRequest : NSObject


+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id result))sucess failed:(void (^)(NSError *error))failed;
@end
