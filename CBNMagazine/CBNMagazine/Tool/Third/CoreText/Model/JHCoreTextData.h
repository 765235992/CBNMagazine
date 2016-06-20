//
//  JHCoreTextData.h
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHCoreTextData : NSObject
@property (assign, nonatomic) CTFrameRef ctFrame;
@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) NSArray * buttonArray;
@property (strong, nonatomic) NSAttributedString *content;

@end
