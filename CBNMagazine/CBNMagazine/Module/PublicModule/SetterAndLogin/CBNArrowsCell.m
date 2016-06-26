//
//  CBNArrowsCell.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/6/16.
//  Copyright © 2016年 上海第一财经有限公司. All rights reserved.
//

#import "CBNArrowsCell.h"

@interface CBNArrowsCell ()
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UIImageView *arrowsImageView;
@property (nonatomic, strong) UIImageView *lineImageView;
@end

@implementation CBNArrowsCell
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
        
        self.dk_backgroundColorPicker = DKColorPickerWithKey(默认背景颜色);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self addSubview:self.keyLabel];
        
        [self addSubview:self.arrowsImageView];
        
        _arrowsImageView.center = CGPointMake(_arrowsImageView.center.x, 50/2);
        
        [self addSubview:self.lineImageView];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 50);
    }
    
    return self;
}

- (UILabel *)keyLabel
{
    if (!_keyLabel) {
        
        self.keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, screen_Width*2/3, 25)];
                
        _keyLabel.font = font_px_Medium(14.0);
        
        _keyLabel.dk_textColorPicker = DKColorPickerWithKey(字体默认颜色);
    }
    
    return _keyLabel;
}

- (UIImageView *)arrowsImageView
{
    if (!_arrowsImageView) {
        
        self.arrowsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_Width-32, 0, 20, 34)];
        
        _arrowsImageView.dk_imagePicker = DKImagePickerWithImages([UIImage imageNamed:@"Setter_arrows_right_day@2x.png"],[UIImage imageNamed:@"Setter_arrows_right_day@2x.png"],[UIImage imageNamed:@"Setter_arrows_right_day@2x.png"]);
        _arrowsImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _arrowsImageView;
}
- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, screen_Width, 1)];

        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(新闻列表分割线颜色);
    }
    
    return _lineImageView;
}
- (void)setSetterDic:(NSDictionary *)setterDic
{
    _keyLabel.text = setterDic[@"key"];
}
@end
