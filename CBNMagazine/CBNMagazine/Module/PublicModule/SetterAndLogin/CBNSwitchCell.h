//
//  CBNSwitchCell.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBNSwitchCell;

@protocol CBNSwitchCellDelegate <NSObject>

- (void)switchChanged:(CBNSwitchCell *)switchCell andSwicth:(UISwitch *)sender;


@end
/*
 *  滑块类型的cell
 */
@interface CBNSwitchCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *setterDic;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic, strong) UISwitch *valueSwitch;

@property (nonatomic, assign)  id <CBNSwitchCellDelegate> delegate;

- (void)configureTheSetterItem:(NSDictionary *)setterItem AtIndexPath:(NSIndexPath *)indexPath;

@end
