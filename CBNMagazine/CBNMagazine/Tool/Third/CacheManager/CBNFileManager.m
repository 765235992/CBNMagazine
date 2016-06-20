//
//  CBNFileManager.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/13.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNFileManager.h"
#define location_Sever @"Jim@163.com"
#define location_account @"Jim"
@implementation CBNFileManager
/*
 *  使用单利，因为要全局使用
 */
+ (CBNFileManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    
    static CBNFileManager *_sharedInstance;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[CBNFileManager alloc] init];
        
    });
    
    return _sharedInstance;
}
- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}
/*
 *  自定义对象保存
 */
- (void)saveCustomObject:(id)object withKey:(NSString *)key
{
    /*
     *  先把自定义对象进行归档
     */
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:myEncodedObject forKey:key];
    
    [defaults synchronize];
    
}

/*
 *  读取自定义对象
 */
- (id)loadCustomObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *myEncodedObject = [defaults objectForKey:key];
    
    if (myEncodedObject == nil) {

        return NULL;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
    
}

/*
 *  保存基本数据类型
 */
- (void)saveBasicDataTypes:(id)basicDataTypes withKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:basicDataTypes forKey:key];
    
    [defaults synchronize];
}

/*
 *  读取基本数据类型
 */
- (id)loadBasicDataTypesWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:key];
    
}

/*
 *  删除某一个NSUserDefaults文件
 */
- (void)deleteUserDefaultsWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults removeObjectForKey:key];
    
}
/*
 *  清空本地所有NSUserDefaults
 */
- (void)cleanUserDefaults
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeVolatileDomainForName:appDomain];
    
    if ([defaults synchronize]) {
        CBNLog(@"清除成功");
    }
    
}

/*
 *  获取本地plist文件地址
 */
- (NSString *)loadPlistFilePathWithPlistName:(NSString *)plistName
{
    return [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
}

/*
 *  因为不需要强制登录，所以需要保存在钥匙串中
 */
- (BOOL)saveBuyReceiptInKeychainWithReceipt:(id)receipt
{
    NSError *error;
    
    NSMutableArray *receiptArray = [NSMutableArray arrayWithArray:[self loadBuyReceiptInKeychain]];
    
    NSDictionary *neweceiptDic = [NSJSONSerialization JSONObjectWithData:receipt options:0 error:nil];
    
    [receiptArray addObject:neweceiptDic];
    
    NSData *newReceiptData = [NSKeyedArchiver archivedDataWithRootObject:receiptArray];
    
    [self deleteBuyReceiptInKeychain];
    
    BOOL isSaveSecuessed = [SSKeychain setPasswordData:newReceiptData forService:location_Sever account:location_account error:&error];
    
    NSLog(@"保存成功？ %d",isSaveSecuessed);
    
    if (error == NULL) {
        
        return YES;
        
    }
    return NO;
    
}


/*
 *  从钥匙串中取出
 */
- (id)loadBuyReceiptInKeychain
{
    NSError *error;
    
    NSData *receiptData = [SSKeychain passwordDataForService:location_Sever account:location_account error:&error];
    
    NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithData:receiptData]);
    
    if (receiptData != nil) {
        
        return [NSKeyedUnarchiver unarchiveObjectWithData:receiptData];
        
    }
    
    return NULL;
}

#warning 慎用，要在同步成功以后才能执行这一个方法，否则绝对不能执行这一个方法。
/*
 *  从钥匙串中删除购买发票
 */
- (void)deleteBuyReceiptInKeychain
{
    
    [SSKeychain deletePasswordForService:location_Sever account:location_account];
    
}
@end
