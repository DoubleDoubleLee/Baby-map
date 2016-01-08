//
//  LSSMainViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSMainViewController.h"
#import "LSSSearchViewController.h"
#import "LSSBabyFoodViewController.h"
#import "LSSBabybreastfeedViewController.h"
#import "LSSBabyHealthyViewController.h"
#import "LSSTitleView.h"
@interface LSSMainViewController () <UIScrollViewDelegate> {
    UIScrollView* _scrollV;
    LSSTitleView* _titleV;
}
@end

@implementation LSSMainViewController

- (void)viewDidLoad
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self setNaviBar];
    [self setHeaderFile];
}
- (void)setHeaderFile
{
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 40, Screen_size.width, Screen_size.height - 49 - 40 - 64)];
    _scrollV.contentSize = CGSizeMake(Screen_size.width * 3, 0);
    _scrollV.delegate = self;
    _scrollV.pagingEnabled = YES;
    _scrollV.directionalLockEnabled = YES;
    _scrollV.bounces = NO;
    _scrollV.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollV];
    [self addSubviewsToScrollV:_scrollV];

    __weak UIScrollView* scrollV = _scrollV;
    _titleV = [[LSSTitleView alloc]
        initWithFrame:CGRectMake(0, 64, Screen_size.width, 40)];
    NSArray* titles = @[ @"宝宝饮食", @"宝宝健康", @"辅食工具" ];

    _titleV.tittles = titles;
    _titleV.buttonSelectAtIndex = ^(NSInteger index) {
        scrollV.contentOffset = CGPointMake(Screen_size.width * index, 0);
    };
    [self.view addSubview:_titleV];
}
- (void)addSubviewsToScrollV:(UIScrollView*)scrollview
{
    LSSBabyFoodViewController* babyFood =
        [[LSSBabyFoodViewController alloc] init];
    LSSBabyHealthyViewController* babyHealth =
        [[LSSBabyHealthyViewController alloc] init];
    LSSBabybreastfeedViewController* babyBreastfeed =
        [[LSSBabybreastfeedViewController alloc] init];
    NSArray* arrVC = @[ babyFood, babyHealth, babyBreastfeed ];
    for (int i = 0; i < 3; i++) {
        UIViewController* vc = arrVC[i];
        vc.view.frame = CGRectMake(Screen_size.width * i, 0, Screen_size.width,
            Screen_size.height - 40 - 49 - 64);
        [_scrollV addSubview:vc.view];
        [self addChildViewController:vc];
    }
}
- (void)setNaviBar
{
    self.sc_navigationItem.title = @"宝宝首页";
    /*
    __weak typeof(self) weakSelf = self;
    SCBarButtonItem* search = [[SCBarButtonItem alloc]
        initWithImage:[UIImage imageNamed:@"search"]
                style:SCBarButtonItemStylePlain
              handler:^(id sender) {
                  //搜索界面
                  LSSSearchViewController* search = [[LSSSearchViewController alloc]
                      initWithNibName:@"LSSSearchViewController"
                               bundle:nil];
                  [weakSelf.navigationController pushViewController:search
                                                           animated:YES];
              }];
    self.sc_navigationItem.rightBarButtonItem = search;
     */
}
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    NSInteger index = scrollView.contentOffset.x / Screen_size.width;
    _titleV.currentPage = index;
}


@end
