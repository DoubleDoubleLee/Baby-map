//
//  LSSBabyShowViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSBabyShowViewController.h"
#import "LSSSendMessageViewController.h"
#import "LSSBabyShowTableViewCell.h"

@interface LSSBabyShowViewController ()

@end

@implementation LSSBabyShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNaviBar];
    [self loadData];
}

- (void)setNaviBar
{
    self.sc_navigationItem.title = @"宝宝晒晒";
    __weak typeof(self) weakSelf = self;
    SCBarButtonItem* camera = [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera"]
                                                               style:SCBarButtonItemStylePlain
                                                             handler:^(id sender) {
                                                                 LSSSendMessageViewController* sendMessage = [[LSSSendMessageViewController alloc] initWithNibName:@"LSSSendMessageViewController" bundle:nil];
                                                                 [weakSelf.navigationController pushViewController:sendMessage
                                                                                                          animated:YES];
                                                             }];
    self.sc_navigationItem.leftBarButtonItem = camera;
}
- (void)createUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height - 49 - 64) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.view addSubview:self.tableV];
}
- (void)loadData
{
    [self loadDataWithPath:[NSString stringWithFormat:Show_URL, self.page]];
    [self.header endRefreshing];
}
- (void)loadDataNextPage
{
    [self loadDataWithPath:[NSString stringWithFormat:Show_URL, ++self.page]];
    [self.footer endRefreshing];
}
- (void)loadDataWithPath:(NSString*)path
{
    NSString* terminalPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    LSSParseData* lss = [[LSSParseData alloc] init];
    lss.delegate = self;
    [lss parseShowData:terminalPath];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     self.tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 400;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    LSSBabyShowTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSSBabyShowTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LSSShowModel* model = self.dataSource[indexPath.row];
    
    [cell updateCellWithModel:model];
    
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
}

@end
