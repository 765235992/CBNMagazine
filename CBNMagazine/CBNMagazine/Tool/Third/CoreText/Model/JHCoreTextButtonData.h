//
//  JHCoreTextButtonData.h
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHCoreTextModle.h"

@interface JHCoreTextButtonData : NSObject
@property (strong, nonatomic) NSString *buttonTitle;
@property (strong, nonatomic) JHCoreTextModle *coreTextModel;
@property (assign, nonatomic) NSRange range;

@end
