//
//  NSDate+CBNDate.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/13.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "NSDate+CBNDate.h"

@implementation NSDate (CBNDate)
/*
 *  取秒差
 */
+ (NSString *)getUTCFormateDate:(NSString *)newsDate
{
    
    
    NSString *yearMonthDays = [self standardDateChangeToNeedTime:[self stringDateChangeToStandardDateWithString:newsDate]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
//    int year = ((int)time)/(3600*24*30*12);
//    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
    int second=((int)time)%(3600*24);
    
    NSString *dateContent;
    if(days!=0){
        if (days >= 4) {
            dateContent = yearMonthDays;
        }else{
            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",days,@"天前"];
            
        }
    }else if(hours!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"",hours,@"小时前"];
    }else if(minute !=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"",minute,@"分钟前"];
    }else {
        if (second == 0) {
            dateContent = [NSString stringWithFormat:@" "];
            
        }else{
            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",second,@"秒前"];
            
        }
    }
    
    return dateContent;
}
/*
 *  字符串转换成标准时间
 */
+ (NSDate *)stringDateChangeToStandardDateWithString:(NSString *)dateString
{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    
    //location设置为中国
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    
    return inputDate;
    
}
/*
 *  标准时间转成想要的字符串时间
 */
+ (NSString *)standardDateChangeToNeedTime:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *str = [outputFormatter stringFromDate:date];
    
    return str;
}
@end
