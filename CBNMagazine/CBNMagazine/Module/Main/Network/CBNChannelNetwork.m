//
//  CBNChannelNetwork.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/18.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChannelNetwork.h"

#define channel_Base_URL @"http://testapi.cbnweek.com/index.php/Index/GetIndexArticleList?kye"

@interface CBNChannelNetwork ()
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, copy) channelRequestSecuessed aSecuessed;
@property (nonatomic, copy) channelRequestFailed aFailed;

@end

@implementation CBNChannelNetwork
- (void)loadChannelInfoWithChannelID:(NSString *)channelID secuessed:(channelRequestSecuessed)secuessed failed:(channelRequestFailed)failed
{
    
    self.aSecuessed = secuessed;
    
    self.aFailed = failed;
    
    NSString *str = [NSString getTheMD5EncryptedStringWithString:@"www_y_z_cbnweek_w_comGetIndexArticleList"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@=%@",channel_Base_URL,str];

    NSURL *url = [NSURL URLWithString:@"http://testapi.cbnweek.com/index.php/Index/GetIndexArticleList?key=6bd7120ac2b6bdb8333a4ac10597c3c3"];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];

}
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    self.receiveData = [NSMutableData data];
    
    
    
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:self.receiveData options:0 error:nil];
    
    if (self.aSecuessed!=nil) {
        self.aSecuessed(result);
    }
    self.receiveData = nil;

}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    self.receiveData = nil;

    if (self.aFailed!=nil) {
        self.aFailed(error);
    }
}
- (void)cannelRequest
{
    [self.connection cancel];
    self.receiveData = nil;
    
}


@end
