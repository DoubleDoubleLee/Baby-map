//
//  LSSShareViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSShareViewController.h"
#import "LSSShareTableViewCell.h"
#import "LSSMainTableViewCell.h"
@interface LSSShareViewController ()

@end

@implementation LSSShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sc_navigationItem.title = @"妈妈分享";

    [self loadData];
}

- (void)createUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height - 64 - 49) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;

    [self.view addSubview:self.tableV];
}
- (void)loadData
{
    [self loadDataWithPath:[NSString stringWithFormat:Share_URL, self.page]];
    [self.header endRefreshing];
}
- (void)loadDataNextPage
{
    [self loadDataWithPath:[NSString stringWithFormat:Share_URL, self.page++]];
    [self.footer endRefreshing];
}

- (void)sendImageData:(NSMutableArray*)imageArr
{
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    LSSShareTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSSShareTableViewCell" owner:self options:nil] lastObject];
    }
    //cell的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LSSMainModel* shareModel = self.dataSource[indexPath.row];
    [cell setShareModel:shareModel];
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    LSSDetailViewController* detail = [[LSSDetailViewController alloc] init];
    LSSMainModel* shareModel = self.dataSource[indexPath.row];
    detail.content = shareModel.contentUrl;
    detail.model = shareModel;
    __weak typeof(self) weakSelf = self;
    [weakSelf.navigationController pushViewController:detail animated:YES];
}
@end
