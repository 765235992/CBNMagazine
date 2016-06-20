//
//  CBNRegisterEvent.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CBNRegisterSecuessed)(id result);

typedef void(^CBNRegisterFailed)(id error);

@interface CBNRegisterEvent : NSObject
/*
 *  检查账号是否注册事件
 *
 *  userID 用户账号
 *
 *  secuessed 登录成功返回值
 *
 *  failed  登录失败返回值
 *
 */
- (void)registerEventUserIDIsRegister:(NSString *)userID secuessed:(CBNRegisterSecuessed)secuessed failed:(CBNRegisterFailed)failed;

/*
 *  注册事件，检查注册的验证码是否有效
 *
 *  verificationCode 验证码
 *
 *  secuessed 登录成功返回值
 *
 *  failed  登录失败返回值
 *
 */
- (void)registerCheckVerificationCodeIsEffectiveEventWithUserInfo:(NSString *)verificationCode secuessed:(CBNRegisterSecuessed)secuessed failed:(CBNRegisterFailed)failed;


/*
 *  注册事件，检查注册的验证码是否有效
 *
 *  userInfo 用户注册信息（包含密码 用户名）
 *
 *  secuessed 登录成功返回值
 *
 *  failed  登录失败返回值
 *
 */
- (void)registerOverWithUserInfo:(NSDictionary *)userInfo secuessed:(CBNRegisterSecuessed)secuessed failed:(CBNRegisterFailed)failed;






@end
