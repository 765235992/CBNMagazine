//
//  CBNSwitchCell.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNSwitchCell.h"
@interface CBNSwitchCell ()
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UIImageView *lineImageView;

@end
@implementation CBNSwitchCell
- (void)dealloc
{
    CBNLog(@"释放 %@",self);
}
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dk_backgroundColorPicker = DKColorPickerWithKey(默认背景颜色);

        [self addSubview:self.keyLabel];
        
        [self addSubview:self.valueSwitch];
        _valueSwitch.center = CGPointMake(_valueSwitch.center.x, 50/2);
        [self addSubview:self.lineImageView];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 50);
    }
    
    return self;
}

- (UILabel *)keyLabel
{
    if (!_keyLabel) {
        
        self.keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, screen_Width*2/3, 25)];
        
        _keyLabel.font = font(14.0);
        _keyLabel.dk_textColorPicker = DKColorPickerWithKey(字体默认颜色);

    }
    
    return _keyLabel;
}
- (UISwitch *)valueSwitch
{
    if (!_valueSwitch) {
        
        self.valueSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(screen_Width-42, 0, 30, 30)];
        _valueSwitch.backgroundColor = [UIColor clearColor];
        
        _valueSwitch.frame = CGRectMake(screen_Width - 12 - _valueSwitch.frame.size.width, 0, _valueSwitch.frame.size.width, _valueSwitch.frame.size.height);
        
        [_valueSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _valueSwitch;
}
- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, screen_Width, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(分割线默认颜色);

    }
    
    return _lineImageView;
}
- (void)setSetterDic:(NSDictionary *)setterDic
{
    _keyLabel.text = setterDic[@"key"];
}

- (void)switchChanged:(UISwitch *)sender {
    
    if ([self.delegate respondsToSelector:@selector(switchChanged:andSwicth:)]) {
        
        [self.delegate switchChanged:self andSwicth:sender];
        
    }
}
- (void)configureTheSetterItem:(NSDictionary *)setterItem AtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    
    _keyLabel.text = setterItem[@"key"];
    
    _valueSwitch.on = [setterItem[@"value"] floatValue];
    
}
@end
