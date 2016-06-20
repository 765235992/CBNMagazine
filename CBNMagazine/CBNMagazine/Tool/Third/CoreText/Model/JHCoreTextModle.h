//
//  JHCoreTextModle.h
//  自定义Label
//
//  Created by huaxianwei on 16/5/26.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    //点击
    JHCoreTextModleButtonType,
    //无点击
    JHCoreTextModleTextType,
} JHCoreTextModleType;

@interface JHCoreTextModle : NSObject
//宽度
@property (nonatomic, assign) CGFloat width;
//字体大小
@property (nonatomic, assign) CGFloat fontSize;
//字体名字
@property (nonatomic, strong) NSString *fontName;
//行间距
@property (nonatomic, assign) CGFloat lineSpace;
//字体颜色
@property (nonatomic, assign) int textColor;
//内容
@property (nonatomic, strong) NSString *text;
//内容类型
@property (nonatomic, assign) JHCoreTextModleType modleType;

@end
