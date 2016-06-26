//
//  CBNProjectModel.h
//  CBNMagazine
//
//  Created by Jim on 16/6/22.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNProjectModel : NSObject
@property (nonatomic, strong) NSString *data_type;
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *subject_id;
@property (nonatomic, strong) NSString *if_interaction;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *interaction_content;
@property (nonatomic, strong) NSString *repost_count;
@property (nonatomic, strong) NSString *show_chapt_img;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updated;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *weight;
- (id)initWithProjectResult:(NSDictionary *)result;

@end
