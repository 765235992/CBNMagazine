//
//  CBNProjectCell.m
//  CBNMagazine
//
//  Created by Jim on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNProjectCell.h"

@implementation CBNProjectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

        [self.contentView addSubview:self.projectImageView];;

        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (CBNImageView *)projectImageView
{
    if (!_projectImageView) {

        self.projectImageView = [[CBNImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
        
        self.projectImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        _projectImageView.image = [UIImage imageNamed:@"defaultImage.jpg"];
    }
    
    return _projectImageView;
}
@end
