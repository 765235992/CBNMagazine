//
//  CBNChannelNewsModel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNChannelNewsModel : NSObject

@property (nonatomic, strong) NSString *chatp_id;
@property (nonatomic, strong) NSString *issue_id;
@property (nonatomic, strong) NSString *chapt_title;
@property (nonatomic, strong) NSString *index_title;
@property (nonatomic, strong) NSString *renew_time;
@property (nonatomic, strong) NSString *chapt_time;
@property (nonatomic, strong) NSString *click_count;
@property (nonatomic, strong) NSString *cover_img_big;
@property (nonatomic, strong) NSString *data_type;
@property (nonatomic, strong) NSString *release_time;
@property (nonatomic, strong) NSString *sound_time;
@property (nonatomic, strong) NSString *comments;
@property (nonatomic, strong) NSString *like;
@property (nonatomic, assign) CGFloat height;

- (id)initWithChannelNewsInfo:(NSDictionary *)channelNewsInfo andType:(NSInteger)type;
@end
