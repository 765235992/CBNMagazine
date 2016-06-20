//
//  JHCoreTextUtils.h
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHCoreTextButtonData.h"
#import "JHCoreTextData.h"

@interface JHCoreTextUtils : NSObject
+ (JHCoreTextButtonData *)touchButtonInView:(UIView *)view atPoint:(CGPoint)point data:(JHCoreTextData *)data;

+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(JHCoreTextData *)data;
@end
