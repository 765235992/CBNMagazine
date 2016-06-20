//
//  NSString+CBNString.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/13.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CBNString)
+ (NSString *)getTheMD5EncryptedStringWithString:(NSString *)aString;
@end
