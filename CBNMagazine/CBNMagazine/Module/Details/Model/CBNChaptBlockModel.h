//
//  CBNChaptBlockModel.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBNChaptBlockImageModel.h"

@interface CBNChaptBlockModel : NSObject

@property (nonatomic, assign) CGFloat height;
/*
 *  段落ID
 */
@property (nonatomic, assign) NSInteger blockID;
/*
 *  段落类型
 */
@property (nonatomic, strong) NSString *blockType;
/*
 *  文本类型的内容
 */
@property (nonatomic, strong) NSString *blockTextContent;

/*
 *  图片类型的内容
 */
@property (nonatomic, strong) CBNChaptBlockImageModel *blockImageContent;

/*
 *  所有关键字数组
 */
@property (nonatomic, strong) NSMutableArray *keyWordStrArray;
/*
 *  所有关键字内容数组
 */
@property (nonatomic, strong) NSMutableDictionary *keyWordContentDic;

/*
 *  摘录信息
 */
@property (nonatomic, strong) NSMutableArray *readPressArray;

/*
 *  初始化
 */
- (id)initWithBlockResult:(NSDictionary *)blockResult;

@end
