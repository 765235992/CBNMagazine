//
//  UIView+JHFrame.m
//  频道切换
//
//  Created by 滑现伟 on 16/5/17.
//  Copyright © 2016年 Aubrey. All rights reserved.
//

#import "UIView+JHFrame.h"

@implementation UIView (JHFrame)
- (CGFloat)JH_height
{
    return self.frame.size.height;
}

- (CGFloat)JH_width
{
    return self.frame.size.width;
}

- (void)setJH_height:(CGFloat)JH_height {
    CGRect frame = self.frame;
    frame.size.height = JH_height;
    self.frame = frame;
}
- (void)setJH_width:(CGFloat)JH_width {
    CGRect frame = self.frame;
    frame.size.width = JH_width;
    self.frame = frame;
}

- (CGFloat)JH_x
{
    return self.frame.origin.x;
}

- (void)setJH_x:(CGFloat)JH_x {
    CGRect frame = self.frame;
    frame.origin.x = JH_x;
    self.frame = frame;
}


- (CGFloat)JH_y
{
    return self.frame.origin.y;
}


- (void)setJH_y:(CGFloat)JH_y {
    CGRect frame = self.frame;
    frame.origin.y = JH_y;
    self.frame = frame;
}


- (void)setJH_centerX:(CGFloat)JH_centerX {
    CGPoint center = self.center;
    center.x = JH_centerX;
    self.center = center;
}

- (CGFloat)JH_centerX
{
    return self.center.x;
}


- (void)setJH_centerY:(CGFloat)JH_centerY {
    CGPoint center = self.center;
    center.y = JH_centerY;
    self.center = center;
}

- (CGFloat)JH_centerY
{
    return self.center.y;
}

@end
