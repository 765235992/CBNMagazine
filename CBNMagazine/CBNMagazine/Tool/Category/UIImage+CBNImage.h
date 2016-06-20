//
//  UIImage+CBNImage.h
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CBNImage)
/** 返回一张纯色图片 */
+ (UIImage *)imageWithColor:(UIColor *)color andFrame:(CGRect)rect;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)colorImage;

@end
