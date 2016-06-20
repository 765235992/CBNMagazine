//
//  CBNProjectLayout.m
//  CBNMagazine
//
//  Created by Jim on 16/6/20.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNProjectLayout.h"

#define width (((screen_Width - 45)/2))


@implementation CBNProjectLayout
-(id)init
{
    self = [super init];
    if (self) {
        
        self.itemSize = CGSizeMake((float)width, (float)width/2);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //  确定了缩进，此处为上方、下方各缩进200
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //  每个item在水平方向的最小间距
        self.minimumLineSpacing = 10;
        NSLog(@"%f",(float)width);
    }
    return self;
}
@end
