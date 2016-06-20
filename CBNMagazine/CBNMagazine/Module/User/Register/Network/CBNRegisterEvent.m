//
//  CBNRegisterEvent.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNRegisterEvent.h"
#define user_Center_Base_URL @"http://www.cbnweek.com/v/"
/*
 *  验证手机号是否注册
 */
#define user_Center_Register_Validate_UserID_Is_Register @"isms_new_api"

/*
 *  验证验证码是否有效
 */
#define user_Center_Register_Validate_Code_Is_Effective @"phone_reg_validate_api"

#define user_Finished_Step @"phone_reg_api"
@interface CBNRegisterEvent ()
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, copy) CBNRegisterSecuessed aSecuessed;
@property (nonatomic, copy) CBNRegisterFailed aFailed;

@end
@implementation CBNRegisterEvent
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
- (void)registerEventUserIDIsRegister:(NSString *)userID secuessed:(CBNRegisterSecuessed)secuessed failed:(CBNRegisterFailed)failed
{
    self.aSecuessed = secuessed;
    
    self.aFailed = failed;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    [parameter setObject:userID forKey:@"phone"];
    
    self.userID = userID;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",user_Center_Base_URL,user_Center_Register_Validate_UserID_Is_Register];
    
    [self getEventWithURL:urlStr andParameter:parameter];

}
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
- (void)registerCheckVerificationCodeIsEffectiveEventWithUserInfo:(NSString *)verificationCode secuessed:(CBNRegisterSecuessed)secuessed failed:(CBNRegisterFailed)failed
{
    self.aSecuessed = secuessed;
    
    self.aFailed = failed;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    [parameter setObject:self.userID forKey:@"phone"];
    
    [parameter setObject:verificationCode forKey:@"mcode"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",user_Center_Base_URL,user_Center_Register_Validate_Code_Is_Effective];
    
    [self postEventWithURL:urlStr andParameter:parameter];
    
}
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
- (void)registerOverWithUserInfo:(NSDictionary *)userInfo secuessed:(CBNRegisterSecuessed)secuessed failed:(CBNRegisterFailed)failed
{
    self.aSecuessed = secuessed;
    
    self.aFailed = failed;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",user_Center_Base_URL,user_Center_Register_Validate_Code_Is_Effective];
    
    [self postEventWithURL:urlStr andParameter:userInfo];
    
}
/*
 *  Get请求事件
 */
- (void)getEventWithURL:(NSString *)urlStr andParameter:(NSDictionary *)parameter
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功 %@ %@",[responseObject objectForKey:@"msg"],responseObject);
        
        if ([[responseObject objectForKey:@"result"] boolValue] == YES) {
            
            self.aSecuessed(responseObject);
            
        }else{
            
            self.aFailed([responseObject objectForKey:@"msg"]);

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        self.aFailed(error);
        
    }];
    
}
/*
 *  Post请求事件
 */
- (void)postEventWithURL:(NSString *)urlStr andParameter:(NSDictionary *)parameter
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功 %@  %@",responseObject,[responseObject objectForKey:@"msg"]);

        if ([[responseObject objectForKey:@"result"] boolValue] == YES) {
            
            
            self.aSecuessed([responseObject objectForKey:@"msg"]);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        self.aFailed(error);
    }];
    
}








@end
