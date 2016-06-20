//
//  CBNLabel.h
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBNLabel : UILabel
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, assign) BOOL isCenter;
@property (nonatomic, assign) NSInteger maxLineNumber;
@property (nonatomic, assign) NSInteger minLineNumber;

@property (nonatomic, strong) NSString *content;

@end
