//
//  LSSTitleView.m
//  ScrollViewCon
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 Double Lee. All rights reserved.
//

#import "LSSTitleView.h"

@implementation LSSTitleView
{
    UIScrollView * _scrollV;
    NSMutableArray * _array;
    UIView * _view;//滑动条
    CGFloat _width;//滑动条的宽
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _array=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)setTittles:(NSArray *)tittles{
    [self addSubviewsWithTitles:tittles];
}
-(void)addSubviewsWithTitles:(NSArray*)tittles{
    //button下面的滚动条
    CGFloat width=self.frame.size.width/tittles.count;
    CGFloat height=self.frame.size.height;
    _width=width;
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, 36, width, 4)];
    _view.backgroundColor=[UIColor colorWithRed:255/256.0 green:88/256.0 blue:119/256.0 alpha:1.0];
    [self addSubview:_view];
    for (int i=0; i<tittles.count;i++) {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(width*i, 0, width, height - 4);
        [button setTitle:tittles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
        [_array addObject:button];//把button放到数组里面
    }
}
-(void)buttonClick:(UIButton *)btn{
    int i=0;
    for (UIButton * button in _array) {
        if (button==btn) {
            button.selected=YES;
            self.buttonSelectAtIndex(i);//block 回调
            [UIView animateWithDuration:0.4 animations:^{
                _view.frame=CGRectMake(i*_width, 36, _width, 4);//设置滚动条的位置
            }];
        }else{
            button.selected=NO;
        }
        i++;
    }
}
-(void)setCurrentPage:(NSInteger)currentPage{
    for (int i=0 ;i<_array.count;i++) {
        UIButton * button=_array[i];
        if (i==currentPage) {
            button.selected=YES;
            [UIView animateWithDuration:0.4 animations:^{
                _view.frame=CGRectMake(i*_width, 36, _width, 4);
            }];
        }else{
            button.selected=NO;
        }
    }
}
@end
