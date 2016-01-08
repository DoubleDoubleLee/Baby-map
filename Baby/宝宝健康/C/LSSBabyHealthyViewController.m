//
//  LSSBabyHealthyViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSBabyHealthyViewController.h"

@interface LSSBabyHealthyViewController ()

@end

@implementation LSSBabyHealthyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}
#pragma mark---子类重写的
- (void)sendImageData:(NSMutableArray*)imageArr
{
    self.imageArray = imageArr;
    [self setAdView];
}
- (void)setAdView
{
    Advertisement* ad = [Advertisement shareWithFrame:CGRectMake(0, 0, Screen_size.width, (Screen_size.height-64)/3) Size:CGSizeMake(Screen_size.width, (Screen_size.height-64)/3) imageUrls:self.imageArray timeInterval:2 showPageControl:YES];
    self.tableV.tableHeaderView = ad;
    [self.tableV reloadData];
}
- (void)loadData
{
    [self loadDataWithPath:[NSString stringWithFormat:Healthy_URL, self.page]];
    [self.header endRefreshing];
}
- (void)loadDataNextPage
{
    [self loadDataWithPath:[NSString stringWithFormat:Healthy_URL, ++self.page]];
    [self.footer endRefreshing];
}

@end
