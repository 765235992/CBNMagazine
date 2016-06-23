//
//  CBNChaptInfoModel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNChaptInfoModel : NSObject
/*
 *  期刊ID
 */
@property (nonatomic, assign) NSInteger issueID;
/*
 *  文章ID
 */
@property (nonatomic, assign) NSInteger chaptID;
/*
 *  文章标题
 */
@property (nonatomic, strong) NSString *chaptTitle;
/*
 *  文章摘要
 */
@property (nonatomic, strong) NSString *chaptBrief;
/*
 *  文章标签名字
 */
@property (nonatomic, strong) NSString *categoryName;
/*
 *  文章是否有图片
 */
@property (nonatomic, assign) BOOL isHavePic;
/*
 *  文章图片地址
 */
@property (nonatomic, strong) NSString *chaptPicURL;
/*
 *  文章图片地址
 */
@property (nonatomic, strong) NSString *chaptTime;
/*
 *  初始化
 */
- (id)initWithChaptInfoResult:(NSDictionary *)chaptInfoResult;



@end
