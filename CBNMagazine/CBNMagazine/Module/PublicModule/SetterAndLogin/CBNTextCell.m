//
//  CBNTextCell.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNTextCell.h"
@interface CBNTextCell ()
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *lineImageView;

@end
@implementation CBNTextCell
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
        
        [self addSubview:self.valueLabel];
        
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

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_Width*2/3+24, 12, screen_Width*1/3 - 36, 25)];
        
        _valueLabel.font = font(14.0);

        _valueLabel.textAlignment = NSTextAlignmentRight;
        
        _valueLabel.dk_textColorPicker = DKColorPickerWithKey(字体默认颜色);

    }
    
    return _valueLabel;
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

    _valueLabel.text = setterDic[@"value"];
    
}
@end
