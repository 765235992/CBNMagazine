//
//  CBNFileManager.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/13.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//
/*
 *  本地文件缓存类，
 *
 *  可以进行本地userdefaults文件存取，支持对象与基本数据类型的存取
 *
 *  可以对钥匙串内容进行存取
 *
 *  可以进行plist文件读取
 */
#import <Foundation/Foundation.h>

@interface CBNFileManager : NSObject
/*
 *  使用单利，因为要全局使用
 */
+ (CBNFileManager *)sharedInstance;

/*
 *  自定义对象保存
 */
- (void)saveCustomObject:(id)object withKey:(NSString *)key;

/*
 *  读取自定义对象
 */
- (id)loadCustomObjectWithKey:(NSString *)key;

/*
 *  保存基本数据类型
 */
- (void)saveBasicDataTypes:(id)basicDataTypes withKey:(NSString *)key;

/*
 *  读取基本数据类型
 */
- (id)loadBasicDataTypesWithKey:(NSString *)key;

/*
 *  删除某一个NSUserDefaults文件
 */
- (void)deleteUserDefaultsWithKey:(NSString *)key;

/*
 *  清空本地所有NSUserDefaults
 */
- (void)cleanUserDefaults;


/*
 *  获取本地plist文件地址
 */
- (NSString *)loadPlistFilePathWithPlistName:(NSString *)plistName;


/*
 *  因为不需要强制登录，所以需要保存在钥匙串中
 */
- (BOOL)saveBuyReceiptInKeychainWithReceipt:(id)receipt;

/*
 *  从钥匙串中取出
 */
- (id)loadBuyReceiptInKeychain;

#warning 慎用，要在同步成功以后才能执行这一个方法，否则绝对不能执行这一个方法。
/*
 *  从钥匙串中删除购买发票
 */
- (void)deleteBuyReceiptInKeychain;
@end
