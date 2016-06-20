//
//  JHCTLabel.h
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//
//NSArray *arr31 = @[@{@"width":@"200",
//                     @"fontSize":[NSNumber numberWithInt:16],
//                     @"lineSpace":[NSNumber numberWithInt:16],
//                     @"textColor":[NSNumber numberWithInt:0x68228B],
//                     @"modleType":[NSNumber numberWithInt:JHCoreTextModleTextType]
//                     ,@"text":@"今天是一个号日子啊tt"},
//                   @{@"width":@"200",
//                     @"fontSize":[NSNumber numberWithInt:16],
//                     @"lineSpace":[NSNumber numberWithInt:16],
//                     @"textColor":[NSNumber numberWithInt:0x68228B],
//                     @"modleType":[NSNumber numberWithInt:JHCoreTextModleTextType]
//                     ,@"text":@"今天是一个号日子啊tt"},
//                   @{@"width":@"200",
//                     @"fontSize":[NSNumber numberWithInt:16],
//                     @"lineSpace":[NSNumber numberWithInt:16],
//                     @"textColor":[NSNumber numberWithInt:0x68228B],
//                     @"modleType":[NSNumber numberWithInt:JHCoreTextModleTextType]
//                     ,@"text":@"今天是一个号日子啊tt"}];
#import <UIKit/UIKit.h>
#import "JHCoreTextData.h"
#import "JHCoreTextModle.h"


@interface JHCTLabel : UIView

@property (nonatomic, copy) void (^labelClicked)(JHCoreTextModle *sender);
@property (nonatomic, strong) NSArray *sourceArray;
@end
