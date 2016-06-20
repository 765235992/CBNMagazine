//
//  CBNUserModel.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/15.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNUserModel.h"

@implementation CBNUserModel

/*
 *  使用单利，因为要全局使用
 */
+ (CBNUserModel *)sharedInstance
{
    static dispatch_once_t onceToken;
    
    static CBNUserModel *_sharedInstance;
    
    dispatch_once(&onceToken, ^{
        
        
        _sharedInstance = [[CBNUserModel alloc] init];
        
    });
    
    return _sharedInstance;
}
- (id)init
{
    self = [super init];
    
    if (self) {
        self.userInfo = [[NSMutableDictionary alloc] init];
        self.isLogin = NO;
        [self loacalUser];
    }
    
    return self;
}
- (void)loacalUser
{
    NSDictionary *uesrInfo = [[CBNFileManager sharedInstance] loadBasicDataTypesWithKey:@"user"];
    
    [self setUserModelWithUserInfo:uesrInfo];
    
    
}
/*
 *  反归档
 */
-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:self.ifmod forKey:@"ifmod"];
    [encoder encodeObject:self.isBind forKey:@"isBind"];
    [encoder encodeObject:self.isCBNUser forKey:@"isCBNUser"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.uemail forKey:@"uemail"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    
}
/*
 *  归档
 */
- (id)initWithCoder:(NSCoder *)decoder {
    
    if (self = [super init]) {
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
        self.ifmod = [decoder decodeObjectForKey:@"ifmod"];
        self.isBind = [decoder decodeObjectForKey:@"isBind"];
        self.isCBNUser = [decoder decodeObjectForKey:@"isCBNUser"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.uemail = [decoder decodeObjectForKey:@"uemail"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    
    return self;   
    
}
/*
 *  重置
 */
- (void)setUserModelWithUserInfo:(NSDictionary *)userInfo
{
   /*
    *   根据用户信息判断用户是否已经登录
    */
    if (userInfo.count > 0) {
        
        self.isLogin = YES;
        
    }else{
        
        self.isLogin = NO;

    }
    [self.userInfo removeAllObjects];
    [self.userInfo addEntriesFromDictionary:userInfo];
    

    self.uid = [userInfo objectForKey:@"uid"];
    self.uemail = [userInfo objectForKey:@"uemail"];
    self.nickname = [userInfo objectForKey:@"nickname"];
    self.isCBNUser = [userInfo objectForKey:@"isCBNUser"];
    self.isBind = [userInfo objectForKey:@"isBind"];
    self.ifmod = [userInfo objectForKey:@"ifmod"];
    self.avatar = [userInfo objectForKey:@"avatar"];
}
/*
 *  修改用户相应信息
 */
- (void)changeUserPropertyWithKey:(NSString *)key andValue:(NSString *)value
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithDictionary:[[CBNFileManager sharedInstance] loadBasicDataTypesWithKey:@"user"]];
    
    [userInfo setObject:value forKey:key];
    
    [[CBNFileManager sharedInstance] saveBasicDataTypes:userInfo withKey:@"user"];

    [self setUserModelWithUserInfo:userInfo];

}
- (NSString *)userPhoneNumber
{
    return @"huzhixin@yicai.com" ;
}
- (NSString *)ueserPassword
{
    return [NSString getTheMD5EncryptedStringWithString:@"cbnweek"];
}

//- (NSString *)userPhoneNumber
//{
//    return [[CBNFileManager sharedInstance] loadBasicDataTypesWithKey:@"userPhoneNumber"];
//}
//- (NSString *)ueserPassword
//{
//    return [[CBNFileManager sharedInstance] loadBasicDataTypesWithKey:@"ueserPassword"];
//}

@end
