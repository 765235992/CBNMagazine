//
//  CBNBarBurronItem.m
//  CBNMagazine
//
//  Created by Jim on 16/6/17.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNBarBurronItem.h"

@interface CBNBarBurronItem ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation CBNBarBurronItem
//- (id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
-(instancetype)initWithTarget:(id)target action:(SEL)action andFrame:(CGRect)rect andImage:(UIImage *)image
{
    
    UIButton *button = [self createButton:rect andImage:image];
    
    self = [self initWithCustomView:button];
    if(self){
        [self setButton:button];
    }
//    self.style = UIBarButtonItemStyleBordered;
    self.action = action;
    
    self.target = target;
    
    return self;
}

- (UIButton *)createButton:(CGRect)rect andImage:(UIImage *)image
{
    UIButton *buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    buttonView.frame = rect;
    
    [buttonView setImage:image forState:UIControlStateNormal];
    
    [buttonView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return buttonView;
    
}
-(void)buttonClicked:(id)sender{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.action withObject:sender];
#pragma clang diagnostic pop;
    
}

-(instancetype)initWithTarget:(id)target action:(SEL)action andFrame:(CGRect)rect andImagePicker:(DKImagePicker)imagePicker
{
    UIButton *button = [[UIButton alloc] initWithFrame:rect];

    [button dk_setImage:imagePicker forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self = [self initWithCustomView:button];
    
    
    if(self){
        
        [self setButton:button];
    }
    self.action = action;
    
    self.target = target;
    
    return self;

}
@end
