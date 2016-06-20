//
//  CBNCacheManager.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/13.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNCacheManager : NSObject
@property (nonatomic, strong) NSString *name;
/*
 *  使用单利，因为要全局使用
 */
+ (CBNCacheManager *)sharedInstance;


@end
