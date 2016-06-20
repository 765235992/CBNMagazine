//
//  CBNLoginEvent.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNLoginEvent.h"
#define user_Center_Base_URL @"http://www.cbnweek.com/v/"

/*
 *  登录
 */
#define user_Center_Login @"phone_login_api"

@interface CBNLoginEvent ()

@property (nonatomic, copy) CBNLoginSecuessed aSecuessed;
@property (nonatomic, copy) CBNFailed aFailed;

@end

@implementation CBNLoginEvent

- (void)CBNLoginWithUserID:(NSString *)userID password:(NSString *)userPassWord secuessed:(CBNLoginSecuessed)secuessed failed:(CBNFailed)failed
{
    self.aSecuessed = secuessed;
    
    self.aFailed = failed;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    [parameter setObject:userID forKey:@"username"];
    
    [parameter setObject:[NSString getTheMD5EncryptedStringWithString:userPassWord] forKey:@"pwd"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",user_Center_Base_URL,user_Center_Login];
    
    [self getEventWithURL:urlStr andParameter:parameter];
    
}
/*
 *  Get请求事件
 */
- (void)getEventWithURL:(NSString *)urlStr andParameter:(NSDictionary *)parameter
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
        
        if ([[responseObject objectForKey:@"result"] boolValue] == YES) {
            
            [[CBNFileManager sharedInstance] saveBasicDataTypes:[responseObject objectForKey:@"info"]withKey:@"user"];
            
            [[CBNUserModel sharedInstance] setUserModelWithUserInfo:[responseObject objectForKey:@"info"]];
            
            self.aSecuessed(responseObject);
            
        }else{
            
            self.aFailed([responseObject objectForKey:@"msg"]);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        self.aFailed(error);
        
    }];
    
}
+ (void)loginOut
{
    [[CBNFileManager sharedInstance] deleteUserDefaultsWithKey:@"user"];
    
    [[CBNUserModel sharedInstance] setUserModelWithUserInfo:nil];

}
- (void)dealloc
{
    NSLog(@"释放");
}
@end
