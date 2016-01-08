//
//  LSSDetailViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSDetailViewController.h"

@interface LSSDetailViewController () <UIWebViewDelegate> {
    UIWebView* _webView;
}

@end

@implementation LSSDetailViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self setNaviBar];
    [self createWebView];
    [self loadData];
}
- (void)setNaviBar
{
    self.sc_navigationItem.title = @"宝宝知识";
#warning 添加__weak相关的注释来解释说明
    __weak typeof(self) weakSelf = self;
    SCBarButtonItem* back = [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"]
                                                             style:SCBarButtonItemStylePlain
                                                           handler:^(id sender) {
                                                               [weakSelf.navigationController popViewControllerAnimated:YES];
                                                           }];
    //收藏
    UIButton* favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    if (self.model.isSave == nil) {
        [favoriteBtn setImage:[UIImage imageNamed:@"favor"] forState:UIControlStateNormal];
    }
    else {
        [favoriteBtn setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    }

    [favoriteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    SCBarButtonItem* favorite = [[SCBarButtonItem alloc] initWithCustomView:favoriteBtn];
    self.sc_navigationItem.leftBarButtonItem = back;
    self.sc_navigationItem.rightBarButtonItem = favorite;
}
- (void)btnClick:(UIButton*)button
{
    LSSDBManager* manager = [LSSDBManager defaultDBManager];
    if (self.model.isSave == nil) {
        //保存数据
        [manager addData:self.model]; //收藏的是一个模型
        //给isSave赋值
        self.model.isSave = @"成功";
        [button setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    }
    else {
        self.model.isSave = nil;
        [manager deleteDatawithTitle:self.model.title];
        [button setImage:[UIImage imageNamed:@"favor"] forState:UIControlStateNormal];
    }
}
- (void)createWebView
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}
- (void)loadData
{
    NSURL* url = [NSURL URLWithString:self.content];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}
#pragma mark--UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error
{
    NSLog(@"加载失败");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
