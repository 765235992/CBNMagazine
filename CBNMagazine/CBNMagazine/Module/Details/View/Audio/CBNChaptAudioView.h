//
//  CBNChaptAudioView.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBNChaptAudioView : UIView
@property (nonatomic, copy) void (^audioButtonState)(UIButton *sender);

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) NSString *timeText;

@property (nonatomic, strong) CBNLabel *timeLabel;

@end
