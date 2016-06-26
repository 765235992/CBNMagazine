//
//  HXWAudioPlayer.h
//  音乐播放器
//
//  Created by huaxianwei on 16/6/25.
//  Copyright © 2016年 Jim. All rights reserved.
//
/*
 *  音频播放器
 *  支持后台播放
 *  支持来电打断继续播放
 *
 *  需要在需要播放的控制器下ViewDidLoad方法下添加 [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil]; 这一句话，否则后台不能控制
 *  同时  添加下面的方法
 *  在 viewDidAppear 接受远程控制
- (void)audioBeginReceivingRemoteControlEvents
{
    
    [self becomeFirstResponder];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
}
 *  在 viewDidDisappear 取消远程控制
- (void)audioEndReceivingRemoteControlEvents
{
    [self resignFirstResponder];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    
}
 */
#import <Foundation/Foundation.h>
#import "HXWAudioModel.h"
#import <UIKit/UIKit.h>
/*
 *  播放器当前状态
 */
typedef NS_ENUM(NSInteger, HXWAudioPlayerState) {
    /**
     * 没有进行任何设置.
     */
    HXWAudioPlayerStateNone = 0,
    /**
     * 播放器当前正在播放
     */
    HXWAudioPlayerIsPlaying = 1,
    /**
     * 播放器当前处于暂停状态
     */
    HXWAudioPlayerIsPause = 2,

    /**
     * 播放器内容播放结束
     */
    HXWAudioPlayerIsPlayStop = 3,
    /**
     *  播放失败
     */
    HXWAudioPlayerPlayFailed = 4

};

@interface HXWAudioPlayer : UIView

@property (nonatomic, copy) void (^ audioTime)(NSString *totaleTime, NSString *currentTime, NSString *surplusTime);
@property (nonatomic, copy) void (^ audioPlayerState)(HXWAudioPlayerState state);
@property (nonatomic, strong) HXWAudioModel *audioModel;
/*
 *  播放
 */
- (void)play;
/*
 *  暂停
 */
- (void)pause;
/*
 *  暂停变播放
 */
- (void)pauseChangeToPlaying;

/*
 *  播放变暂停
 */
- (void)playingChangeToPause;





@end
