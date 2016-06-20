//
//  CBNChannelNetwork.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^channelRequestSecuessed)(id result);
typedef void(^channelRequestFailed)(id error);

@interface CBNChannelNetwork : NSObject

@property (nonatomic, strong) NSMutableData *receiveData;

- (void)loadChannelInfoWithChannelID:(NSString *)channelID secuessed:(channelRequestSecuessed)secuessed failed:(channelRequestFailed)failed;

- (void)cannelRequest;
@end
