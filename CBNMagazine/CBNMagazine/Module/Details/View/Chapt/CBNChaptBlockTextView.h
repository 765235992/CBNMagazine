//
//  CBNChaptBlockTextView.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CBNChaptBlockModel.h"
/*
 *  关键字事件
 */
typedef void(^CBNChaptTextKeyWordClicked)(NSDictionary *keyWordInfo);
/*
 *  复制事件
 */
typedef void(^CBNChaptTextCopyAction)(NSDictionary *copyInfo);

/*
 *  摘录事件
 */
typedef void(^CBNChaptTextReadPressedAction)(NSDictionary *readPressedInfo);
/*
 *  取消摘录事件
 */
typedef void(^CBNChaptTextCancleReadPressedAction)(NSDictionary *cancleReadPressedInfo);

@interface CBNChaptBlockTextView : UITextView


@property (nonatomic, strong) CBNChaptBlockModel *chaptBlockModel;
/*
 *  关键字点击
 */
- (void)CBNChaptKeyWordClicked:(CBNChaptTextKeyWordClicked)keyWordClicked copyAction:(CBNChaptTextCopyAction)copyAction readPressedAction:(CBNChaptTextReadPressedAction)readPressedAction cancleReadPressedAction:(CBNChaptTextCancleReadPressedAction)cancleReadPressedAction;
@end
