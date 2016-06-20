//
//  CBNSynchronousPermissionsCell.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNSynchronousPermissionsCell.h"

@interface CBNSynchronousPermissionsCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *synchronousContentLabel;

@end

@implementation CBNSynchronousPermissionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.iconImageView];
        
        [self addSubview:self.synchronousContentLabel];
        
    }
    
    return self;
}

- (UILabel *)synchronousContentLabel
{
    if (!_synchronousContentLabel) {
        
        self.synchronousContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 10, screen_Width - 56, 0)];
        
        _synchronousContentLabel.numberOfLines = 0;
        
        _synchronousContentLabel.dk_textColorPicker = DKColorPickerWithKey(字体默认颜色);
        _synchronousContentLabel.font = font(15.0);
    }
    
    return _synchronousContentLabel;
}
- (void)setSynchronousPermissionsText:(NSString *)synchronousPermissionsText
{
    
    _synchronousPermissionsText = synchronousPermissionsText;
    
    self.synchronousContentLabel.attributedText = [_synchronousContentLabel titleLabelAttributedStringWithString:synchronousPermissionsText];
    
    [_synchronousContentLabel sizeToFit];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _synchronousContentLabel.frame.origin.y + _synchronousContentLabel.frame.size.height + 20);

}


@end
