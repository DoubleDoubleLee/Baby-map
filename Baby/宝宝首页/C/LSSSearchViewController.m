//
//  LSSSearchViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSSearchViewController.h"

@interface LSSSearchViewController ()

@end

@implementation LSSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNaviBar];

}

-(void)setNaviBar{
#warning 添加__weak相关的注释来解释说明
    __weak typeof(self)weakSelf=self;

    SCBarButtonItem * back=[[SCBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"forward"] style:SCBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    self.sc_navigationItem.leftBarButtonItem=back;
}
//隐藏tabBar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
//设置基控制器继承然后重写这两个方法 显示tabBar
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

@end
