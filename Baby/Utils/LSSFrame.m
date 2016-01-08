//
//  LSSFrame.m
//  Baby
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSFrame.h"

#define kName_font  [UIFont boldSystemFontOfSize:16]
#define kSubname_font [UIFont systemFontOfSize:12]

@implementation LSSFrame

-(void)setShowModel:(LSSShowModel *)showModel{
    
    _showModel=[[LSSShowModel alloc]init];
    
    _headImage=CGRectMake(10, 5, 50, 50);
    //名字
    NSString * name=_showModel.creatorNickName;
    NSDictionary * NameAttibute=@{NSFontAttributeName:kName_font};
    CGSize nameSize=[name sizeWithAttributes:NameAttibute];
    _nameL=CGRectMake(CGRectGetMaxX(_headImage), 5, nameSize.width, nameSize.height);
    //地址
    NSString * detail=[NSString stringWithFormat:@"%@·%@", _showModel.city, _showModel.region];
    CGSize detailSize =[detail sizeWithAttributes:@{NSFontAttributeName:kSubname_font}];
    _detailL = CGRectMake(CGRectGetMaxX(_headImage)+30, CGRectGetMaxY(_nameL), detailSize.width, detailSize.height);
    //内容
    NSString * content;
    
    if ([showModel.content class] == [NSNull class]) {
       content = [NSString stringWithFormat:@"%@。",showModel .text];
    }
    else {
       content= [NSString stringWithFormat:@"%@。%@。", showModel.text, showModel.content];
    }
    CGSize contentSize=[content sizeWithAttributes:@{NSFontAttributeName:kSubname_font}];
    _contentL=CGRectMake(10, CGRectGetMaxY(_detailL), contentSize.width, 60);
    
    _cellHeight=CGRectGetMaxY(_contentL);

}
@end
