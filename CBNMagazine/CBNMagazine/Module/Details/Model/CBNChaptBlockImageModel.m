//
//  CBNChaptBlockImageModel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptBlockImageModel.h"

@implementation CBNChaptBlockImageModel
- (id)initWithBlockImageResult:(NSDictionary *)imageResult
{
    self = [super init];
    
    if (self) {
        
        /*
         *  图片名字
         */
        self.imageName = [imageResult objectForKey:@"image_name"];
        
        /*
         *  图片标题
         */
        self.imageTitle = [imageResult objectForKey:@"image_title"];
        
        /*
         *  图片地址
         */
        self.imageURL = [imageResult objectForKey:@"image_url"];
        
        /*
         *  小图片地址
         */
        self.minImageURL = [imageResult objectForKey:@"min_image_url"];
        
        /*
         *  图片宽度
         */
        self.imageWidth = [[imageResult objectForKey:@"width"] floatValue];
        
        /*
         *  图片高度
         */
        self.imageHeight = [[imageResult objectForKey:@"height"] floatValue];
        
        
        /*
         *  图片是否为图标
         */
        self.isChart = [[imageResult objectForKey:@"if_chart"] boolValue];
        
    }
    
    return self;
}
- (void)dealloc
{
    NSLog(@"释放 -- %@",self);
}

@end
