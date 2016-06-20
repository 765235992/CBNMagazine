//
//  JHCTFrameAssembleParser.h
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHCoreTextData.h"
#import "JHCoreTextButtonData.h"
/*
 *  拼接组装解析
 */
@interface JHCTFrameAssembleParser : NSObject
/*
 *  根据要求进行配置
 *
 *  requirementsArray 要求列表
 *
 */
+ (JHCoreTextData *)assembleDataOnRequestWithRequirements:(NSArray *)requirementsArray;

@end
