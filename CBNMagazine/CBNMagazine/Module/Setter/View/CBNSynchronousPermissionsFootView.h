//
//  CBNSynchronousPermissionsFootView.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CBNSynchronousPermissionsFootView : UIView

@property (nonatomic, copy) void(^synchronousButtonClicked)();

@end
