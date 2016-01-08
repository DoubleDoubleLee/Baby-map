//
//  LSSFavoriteViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSFavoriteViewController.h"
#import "LSSMainTableViewCell.h"
@interface LSSFavoriteViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    UITableView* _tableV;
    NSMutableArray* _dataSource;
    UILabel* _label;
}
@end

@implementation LSSFavoriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavi];
    [self initDataSource];
    [self createTableV];
    [self readData];
    [self showLabel];
}
- (void)setNavi
{
    self.sc_navigationItem.title = @"我的收藏";
    SCBarButtonItem* delete = [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete"]
                                                               style:SCBarButtonItemStylePlain
                                                             handler:^(id sender) {
                                                                 if ([_tableV isEditing] == YES) {
                                                                     [_tableV setEditing:NO];
                                                                 }
                                                                 else {
                                                                     [_tableV setEditing:YES];
                                                                 }

                                                             }];
    self.sc_navigationItem.rightBarButtonItem = delete;
}
- (void)initDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
}
- (void)createTableV
{
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.rowHeight = 150;
    _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
}
- (void)readData
{
    [_dataSource removeAllObjects];
    LSSDBManager* manager = [LSSDBManager defaultDBManager];
    [_dataSource addObjectsFromArray:[manager allData]];
    [_tableV reloadData];
}
- (void)showLabel
{

    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height / 2)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor colorWithWhite:0.733 alpha:1.000];
    _label.text = @"您还没有收藏内容哦~~";

    if (!_dataSource.count) {

        [_tableV addSubview:_label];
    }
    else {
        [_label removeFromSuperview];
    }
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    LSSMainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSSMainTableViewCell" owner:self options:nil] lastObject];
    }
    LSSMainModel* mo = _dataSource[indexPath.row];
    [cell setModel:mo];
    return cell;
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //1.删除数据库中的数据
        LSSDBManager* manager = [LSSDBManager defaultDBManager];
        LSSMainModel* mo = _dataSource[indexPath.row];

        [manager deleteDatawithTitle:mo.title];
        //2.删除数据源中的数据
        [_dataSource removeObjectAtIndex:indexPath.row];
        //3.删除tableV对应的行
        [_tableV deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableV reloadData];
    }
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    LSSDetailViewController* detail = [[LSSDetailViewController alloc] initWithNibName:@"LSSDetailViewController" bundle:nil];
    LSSMainModel* mo = _dataSource[indexPath.row];
    detail.content = mo.contentUrl;
    detail.model = mo;

    __weak typeof(self) weakSelf = self;
    [weakSelf.navigationController pushViewController:detail animated:YES];
}
@end
