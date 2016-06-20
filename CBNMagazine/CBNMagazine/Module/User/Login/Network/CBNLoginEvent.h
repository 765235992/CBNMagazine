//
//  CBNLoginEvent.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBNUserModel.h"

typedef void(^CBNLoginSecuessed)(CBNUserModel *user);

typedef void(^CBNFailed)(id error);
@interface CBNLoginEvent : NSObject

- (void)CBNLoginWithUserID:(NSString *)userID password:(NSString *)userPassWord secuessed:(CBNLoginSecuessed)secuessed failed:(CBNFailed)failed;

+ (void)loginOut;
@end
