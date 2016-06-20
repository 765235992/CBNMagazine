//
//  CBNChaptBlockImageModel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNChaptBlockImageModel : NSObject
/*
 *  图片名字
 */
@property (nonatomic, strong) NSString *imageName;
/*
 *  图片标题
 */
@property (nonatomic, strong) NSString *imageTitle;
/*
 *  图片地址
 */
@property (nonatomic, strong) NSString *imageURL;
/*
 *  小图片地址
 */
@property (nonatomic, strong) NSString *minImageURL;
/*
 *  图片宽度
 */
@property (nonatomic, assign) float imageWidth;
/*
 *  图片高度
 */
@property (nonatomic, assign) float imageHeight;

/*
 *  图片是否为图标
 */
@property (nonatomic, assign) BOOL isChart;

/*
 *  图片类型
 */
@property (nonatomic, strong) NSString *imageType;;

/*
 *  关键字
 */
@property (nonatomic, strong) NSDictionary *keyWordInfo;

- (id)initWithBlockImageResult:(NSDictionary *)imageResult;

@end
