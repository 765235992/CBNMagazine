//
//  CBNRelatedContentWebVC.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 *  该类仅限于展示周刊介绍自己的相关信息
 */

typedef NS_ENUM(NSUInteger, CBNRelatedContentWebVCType) {
    CBNSina,
    CBNHelp,

};

@interface CBNRelatedContentWebVC : UIViewController

- (id)initWithRelatedContentWebVCType:(CBNRelatedContentWebVCType)relatedContentWebVCType;
@end
