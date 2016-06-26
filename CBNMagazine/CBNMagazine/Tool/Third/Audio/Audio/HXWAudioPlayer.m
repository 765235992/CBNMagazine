//
//  HXWAudioPlayer.m
//  音乐播放器
//
//  Created by huaxianwei on 16/6/25.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "HXWAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


static NSString *const HXWAudioPlayerItemStatusKeyPath = @"status";
static NSString *const HXWAudioPlayerItemLoadedTimeRangesKeyPath = @"loadedTimeRanges";

@interface HXWAudioPlayer ()
/*
 *  播放状态
 */
@property (nonatomic, assign) HXWAudioPlayerState playerState;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerItem *currentPlayItem;

/*
 *  观察者
 */
@property (nonatomic,strong) id observer;

/*
 *  持续时间
 */
@property (nonatomic,assign,readonly) float duration;
@property (nonatomic,strong) NSTimer *progressUpdateTimer;

@property (nonatomic, assign) int totalSeconds;


@end

@implementation HXWAudioPlayer


- (void)dealloc
{
    NSLog(@"释放了吗收音机");

    [self clearObserver];
}
- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        /*
         *  监听来电
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorPhoneState:) name:AVAudioSessionInterruptionNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willDealloc) name:@"willDealloc" object:nil];

        
        _playerState = HXWAudioPlayerStateNone;
        
    }
    return self;
}
- (void)willDealloc
{
    if (_progressUpdateTimer) {
        [_progressUpdateTimer invalidate], _progressUpdateTimer = nil;
    }

}
- (AVPlayer *)player
{
    if (!_player) {
        
        self.player = [[AVPlayer alloc] init];
    }
    
    return _player;
}

- (void)setAudioModel:(HXWAudioModel *)audioModel
{
    /*
     *  判断是否是正确的播放地址，空直接返回
     */
    if (audioModel.audioURLString == nil) {
        
        //空直接返回
        return;
        
    }
    if (_playerState == HXWAudioPlayerIsPlaying) {
        //如果当前正在播放，先暂停
        [self playingChangeToPause];
        
    }
    /*
     *  使用playerItem获取视频的信息，当前播放时间，总时间等
     */
    if (self.currentPlayItem) {
        //清空旧的监听、观察者之类的
        [self clearObserver];
        _playerState = HXWAudioPlayerStateNone;
        if (self.audioPlayerState!=nil) {
            
            self.audioPlayerState(_playerState);
            
        }

    }
    /*
     *  对播放地址进行编码
     */
    NSString *newAudioPath = [audioModel.audioURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url ;
    
    if ([newAudioPath hasPrefix:@"http://"] || [newAudioPath hasPrefix:@"https://"]) {
        
        url = [NSURL URLWithString:@"http://flv2.bn.netease.com/videolib3/1606/25/FNdkE2999/SD/movie_index.m3u8"];
    }
//    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"佛祖.f4v" ofType:@"mp4"];
//    url = [NSURL fileURLWithPath:@"http://flv2.bn.netease.com/videolib3/1606/25/FNdkE2999/SD/FNdkE2999-mobile.mp4"];
    /*
     *  获取音频相关信息
     */
    AVPlayerItem *playItem = [[AVPlayerItem alloc]initWithURL:url];
    /*
     *  添加新的监听、观察者
     */
    [self addObserver:playItem];
    
    [self.player replaceCurrentItemWithPlayerItem:playItem];
    
    [self play];
    _progressUpdateTimer = [NSTimer  scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updatePlaybackProgress) userInfo:nil repeats:YES];

//    /*
//     *  状态正在播放
//     */
//    _playerState = HXWAudioPlayerIsPlaying;
//    
//    if (self.audioPlayerState != nil) {
//        _audioPlayerState(_playerState);
//    }

    /*
     *  block中进行弱引用
     */
    __weak HXWAudioPlayer *weakSelf = self;
    self.observer = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_global_queue(0, 0) usingBlock:^(CMTime time) {
        
        if (CMTIME_IS_INDEFINITE(weakSelf.currentPlayItem.duration)) {
            
            return ;
        }
        
        
       
    
    }];

}
- (void)updatePlaybackProgress
{
    if (self.audioTime!=nil) {
        float f = CMTimeGetSeconds(self.currentPlayItem.currentTime);
        
        float max = CMTimeGetSeconds(self.currentPlayItem.duration);

        self.audioTime([self changeToTime:self.currentPlayItem.duration],[self changeToTime:self.currentPlayItem.currentTime],[self secondChangeTonTimeStrWithSecond:(max - f)]);
        
    }
    
}
- (void)backgroundScreenShowInfo
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://vimg1.ws.126.net/image/snapshot/2016/6/1/2/VBPFRO012.jpg"]]];

    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:image];

    NSDictionary *dic = @{MPMediaItemPropertyTitle:@"隔壁的西门大官人",
                          MPMediaItemPropertyArtist:@"张真人",
                          MPMediaItemPropertyArtwork:artWork
                          ,MPMediaItemPropertyPlaybackDuration:[NSNumber numberWithInt:(int)CMTimeGetSeconds(self.currentPlayItem.duration)] };
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
}
/*
 *  播放
 */
- (void)play
{
    
    if (_playerState != HXWAudioPlayerIsPlaying) {
        /*
         *  如果当前播放状态不处于播放状态下，就开始播放
         */
        [_player play];
    }
    
    /*
     *  修改为播放状态
     */
    _playerState = HXWAudioPlayerIsPlaying;
    
    if (self.audioPlayerState != nil) {
        
        _audioPlayerState(_playerState);
        
    }

}
- (void)pause
{
    
    if (_playerState != HXWAudioPlayerIsPause) {
        /*
         *  如果当前播放状态不处于播放状态下，就开始播放
         */
        [_player pause];
    }
    
    /*
     *  修改为暂停状态
     */
    _playerState = HXWAudioPlayerIsPause;
    
    if (self.audioPlayerState != nil) {
        
        _audioPlayerState(_playerState);
    }


    
}
/*
 *  播放变暂停
 */
- (void)playingChangeToPause
{
    if (_playerState == HXWAudioPlayerIsPlaying) {
        /*
         *  如果当前音频正在播放的话，需要把音频暂停
         */
        [_player pause];
        /*
         *  修改为暂停状态
         */

    }
    _playerState = HXWAudioPlayerIsPause;

    if (self.audioPlayerState != nil) {
        
        _audioPlayerState(_playerState);
    }


}
/*
 *  暂停变播放
 */
- (void)pauseChangeToPlaying
{
    if (_playerState == HXWAudioPlayerIsPause) {
        /*
         *  如果当前音频正在处于暂停状态下，音频继续播放
         */
        [_player play];
        /*
         *  修改为暂停状态
         */

    }
    _playerState = HXWAudioPlayerIsPlaying;

    if (self.audioPlayerState != nil) {
        
        _audioPlayerState(_playerState);
    }

}

//清空旧的监听、观察者之类的
- (void)clearObserver {
    if (_progressUpdateTimer) {
        
        [_progressUpdateTimer invalidate], _progressUpdateTimer = nil;
        
    }
    
    if (_observer) {

        [_player removeTimeObserver:_observer];
        
        _observer = nil;
        
    }

    //清空观察者
    
    //清空通知监听
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_currentPlayItem];
    
    //清空当前音频信息同时置空
    [_currentPlayItem removeObserver:self forKeyPath:HXWAudioPlayerItemLoadedTimeRangesKeyPath context:NULL];
    
    [_currentPlayItem removeObserver:self forKeyPath:HXWAudioPlayerItemStatusKeyPath context:NULL];
    
    _currentPlayItem = nil;
    
    

    
    
}

/*
 *  添加新的监听、观察者
 */
- (void)addObserver:(AVPlayerItem *)playItem
{
    self.currentPlayItem = playItem;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playEndNotification) name:AVPlayerItemDidPlayToEndTimeNotification object:playItem];
    
    [playItem addObserver:self forKeyPath:HXWAudioPlayerItemStatusKeyPath options:NSKeyValueObservingOptionNew context:NULL];
    
    [playItem addObserver:self forKeyPath:HXWAudioPlayerItemLoadedTimeRangesKeyPath options:NSKeyValueObservingOptionNew context:NULL];
}
/*
 *  播放完的通知代理执行
 */
- (void)playEndNotification {
    
    
    [self willDealloc];

    [self clearObserver];
    
    _playerState = HXWAudioPlayerIsPlayStop;

    if (self.audioPlayerState!=nil) {
        
        self.audioPlayerState(_playerState);
        
    }
}

#define mark 电话监听
- (void)monitorPhoneState:(NSNotification *)notification
{
    NSAssert([NSThread isMainThread], @"私有流媒体，需要在主线程中进行中进行操作");
    
    NSNumber *interruptionType = [[notification userInfo] valueForKey:AVAudioSessionInterruptionTypeKey];
    
    if ([interruptionType intValue] == AVAudioSessionInterruptionTypeBegan) {
        NSLog(@"来电话了");
        /*
         *  电话进入程序
         */
        [self playingChangeToPause];
        
    } else if ([interruptionType intValue] == AVAudioSessionInterruptionTypeEnded) {
        /*
         *  通话结束
         */
        [self pauseChangeToPlaying];
        
        NSLog(@"打完电话了");

    }
}
/*
 *  KVO观察结果
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:HXWAudioPlayerItemStatusKeyPath]) {
        /*
         *  观察播放状态
         */
        AVPlayerStatus status = [change[NSKeyValueChangeNewKey]integerValue];
        
        if (status == AVPlayerStatusReadyToPlay) {
            
            /*
             *  开始执行，通知代理执行
             */
            [self backgroundScreenShowInfo];

            if (!_progressUpdateTimer) {
                
                _progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updatePlaybackProgress) userInfo:nil repeats:YES];
           
            }

        }
        else if (status == AVPlayerStatusFailed) {
            
            /*
             *  播放失败通知代理执行
             */
            NSLog(@"失败");
            [self clearObserver];
            _playerState = HXWAudioPlayerPlayFailed;
            
            if (self.audioPlayerState!=nil) {
                
                self.audioPlayerState(_playerState);
                
            }

            
        }
        
    }else if ([keyPath isEqualToString:HXWAudioPlayerItemLoadedTimeRangesKeyPath]) {
        
        /*
         *  播放过程中，例如播放进度、播放时间等变化
         */
        if (CMTIME_IS_INDEFINITE(self.currentPlayItem.duration)) {
            
            
            return ;
        }

    }
}

- (NSString *)changeToTime:(CMTime)time
{
    CMTime currentTime = time;
    //转成秒数
    CGFloat currentPlayTime = (CGFloat)currentTime.value/currentTime.timescale;
    
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:currentPlayTime];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (currentPlayTime/3600 >= 1) {
        
        [formatter setDateFormat:@"HH : mm : ss"];
        
    }
    else
    {
        [formatter setDateFormat:@"mm : ss"];
    }
    
    NSString *showtime = [formatter stringFromDate:d];

    return showtime;
    
}
- (NSString *)secondChangeTonTimeStrWithSecond:(CGFloat)seconds
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    if (seconds/3600 >= 1) {
        
        [dateFormatter setDateFormat:@"HH : mm : ss"];

    }
    else
    {
        [dateFormatter setDateFormat:@"mm : ss"];

    }

    NSString* result = [dateFormatter stringFromDate:date];
    
    return result;
}
@end
