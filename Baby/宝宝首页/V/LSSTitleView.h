//
//  LSSTitleView.h
//  ScrollViewCon
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 Double Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSSTitleView : UIView
@property(nonatomic,strong)NSArray * tittles;//头标的个数
@property(nonatomic)NSInteger currentPage;//记录当前页面
@property(nonatomic,copy)void(^buttonSelectAtIndex)(NSInteger index);//很据索引的button方法

@end
