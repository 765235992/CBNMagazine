//
//  CBNChaptAuthorModel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNChaptAuthorModel : NSObject
/*
 *  作者ID
 */
@property (nonatomic, assign) NSInteger authorID;

/*
 *  作者名字
 */
@property (nonatomic, strong) NSString *authorName;

/*
 *  作者是否为实习
 */
@property (nonatomic, assign) BOOL isTrainee;

/*
 *  作者简历
 */
@property (nonatomic, strong) NSString *authorResume;

/*
 *  作者状态
 */
@property (nonatomic, strong) NSString *state;

/*
 *  作者头像
 */
@property (nonatomic, strong) NSString *authorImageURL;

/*
 *  初始化
 */
- (id)initWithAuthorResult:(NSDictionary *)authorResult;

@end
