//
//  CBNChaptBlockModel.m
//  CBNMagazine
//
//  Created by huaxianwei on 16/6/19.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNChaptBlockModel.h"

@implementation CBNChaptBlockModel
/*
 *  初始化
 */
- (id)initWithBlockResult:(NSDictionary *)blockResult
{
    self = [super init];
    
    if (self) {
        /*
         *  段落ID
         */
        self.blockID = [[blockResult objectForKey:@"id"] integerValue];
        
        /*
         *  段落类型
         */
        self.blockType = [blockResult objectForKey:@"type"];
        
        
        self.keyWordStrArray = [[NSMutableArray alloc] initWithArray:[[blockResult objectForKey:@"keyWord"] allKeys]];
        
        
        self.keyWordContentDic = [[NSMutableDictionary alloc]init];
        
        
        
        if ([[blockResult allKeys] containsObject:@"keyWord"]) {
            
            /*
             *  如果包含关键字
             */
            self.keyWordStrArray = [[NSMutableArray alloc] initWithArray:[[blockResult objectForKey:@"keyWord"] allKeys]];
            
            self.keyWordContentDic = [[NSMutableDictionary alloc] initWithDictionary:[blockResult objectForKey:@"keyWord"] ];
            
        }
        
        
        if ([_blockType isEqualToString:@"image"] || [_blockType isEqualToString:@"gif_image"]) {
            /*
             *  图片类型的内容
             */
            self.blockImageContent = [[CBNChaptBlockImageModel alloc] initWithBlockImageResult:[blockResult objectForKey:@"content"]];
            
            _blockImageContent.keyWordInfo = _keyWordContentDic;
            
            
        }else if ([_blockType isEqualToString:@"text"]) {
            /*
             *  文本类型的内容
             */
            self.blockTextContent = [blockResult objectForKey:@"content"];
            
        }else if ([_blockType isEqualToString:@"subtitle"]){
            
            /*
             *  小标题类型
             */
            self.blockTextContent = [blockResult objectForKey:@"content"];
            
        }
        
        
        
        
        
        
        /*
         *  关键字
         */
        //        @property (nonatomic, strong) NSString *blockKeyWordArray;
    }
    
    return self;
}
- (void)dealloc
{
    NSLog(@"释放 -- %@",self);
}


@end
