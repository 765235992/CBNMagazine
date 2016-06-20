//
//  CBNChannelNewsModel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNChannelNewsModel : NSObject
@property (nonatomic, strong) NSString *if_pic;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *mini_image;
@property (nonatomic, strong) NSString *chapt_time;
@property (nonatomic, strong) NSString *lanmu_name;
@property (nonatomic, strong) NSString *chapt_title;
@property (nonatomic, strong) NSString *chapt_brief;
@property (nonatomic, strong) NSString *chapt_id;
@property (nonatomic, strong) NSString *issue_id;
@property (nonatomic, strong) NSString *click_count;
@property (nonatomic, strong) NSString *comm_count;
@property (nonatomic, strong) NSString *customType;
- (id)initWithChannelNewsInfo:(NSDictionary *)channelNewsInfo;
@end
