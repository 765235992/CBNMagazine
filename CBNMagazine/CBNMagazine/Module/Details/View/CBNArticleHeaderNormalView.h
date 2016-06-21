//
//  CBNArticleHeaderNormalView.h
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNChaptInfoModel.h"
#import "CBNChaptAuthorModel.h"
#import "JHCTLabel.h"
#import "CBNLabel.h"
#import "UILabel+CBNLabel.h"
#import "CBNChaptAudioView.h"

@interface CBNArticleHeaderNormalView : UIView
@property (nonatomic, strong) CBNChaptInfoModel *chapt_Info_Model;

@property (nonatomic, strong) NSArray *author_List;

@property (nonatomic, strong) CBNLabel *newsTitleLabel;

@property (nonatomic, strong) JHCTLabel *authorLabel;

@property (nonatomic, strong) CBNImageView *newsThumbImageView;


@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) CBNLabel *newsNotesLabel;

@property (nonatomic, strong) CBNChaptAudioView *audioView;
@end
