//
//  LSSMainRootViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSMainRootViewController.h"

@interface LSSMainRootViewController ()
@property (nonatomic, assign) BOOL isXL;
@end

@implementation LSSMainRootViewController

- (void)viewDidLoad
{
    self.isXL = YES;
    [super viewDidLoad];
    [self initDataSource];
    [self createUI];
    [self refreshData];
}

- (void)initDataSource
{
    _dataSource = [[NSMutableArray alloc] init];
    _page = 1;
    _imageArray = [[NSMutableArray alloc] init];
}
- (void)loadDataWithPath:(NSString*)path
{
    NSString* terminalPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    LSSParseData* lss = [[LSSParseData alloc] init];
    lss.delegate = self;
    [lss parseData:terminalPath];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
}

- (void)sendData:(NSMutableArray*)array
{
    if (self.isXL == YES) {
        self.dataSource = array;

    }
    else {
        [self.dataSource addObjectsFromArray:array];
    }

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableV reloadData];
    });
}
- (void)createUI
{
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height - 49 - 40 - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;

    _tableV.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_tableV];
}
- (void)refreshData
{
    _header = [MJRefreshHeaderView header];
    _footer = [MJRefreshFooterView footer];
    _header.delegate = self;
    _footer.delegate = self;
    _header.scrollView = _tableV;
    _footer.scrollView = _tableV;
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView*)refreshView
{
    if (refreshView == self.header) {
        self.isXL = YES;
        self.page = 1;
        [self loadData];
    }
    else if (refreshView == self.footer) {
        self.isXL = NO;
        [self loadDataNextPage];
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{

    return 150;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* cellID = @"cell";
    LSSMainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSSMainTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LSSMainModel* mo = self.dataSource[indexPath.row];

    [cell setModel:mo];

    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    LSSDetailViewController* detail = [[LSSDetailViewController alloc] initWithNibName:@"LSSDetailViewController" bundle:nil];

    LSSMainModel* mo = self.dataSource[indexPath.row];
    detail.content = mo.contentUrl;
    detail.model = mo;
    __weak typeof(self) weakSelf = self;

    [weakSelf.navigationController pushViewController:detail animated:YES];
}

@end
