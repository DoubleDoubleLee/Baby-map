//
//  LSSBabyHistoryViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSBabyHistoryViewController.h"
#import "LSSBabyHistoryTableViewCell.h"
@interface LSSBabyHistoryViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView* _tableV;
    NSMutableArray* _dataSource;
    UIImageView * _bgV;
    UILabel * _label;//判断是否记录
}
@end

@implementation LSSBabyHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sc_navigationItem.title = @"成长记录";
    [self createUI];
    [self readData];
    [self showLabel];
}
- (void)showLabel
{
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height / 2)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor colorWithWhite:0.733 alpha:1.000];
    _label.text = @"您还没有记录内容哦~~";
    
    if (!_dataSource.count) {
        
        [_tableV addSubview:_label];
    }
    else {
        [_label removeFromSuperview];
    }
}
- (void)createUI
{
    _bgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height - 64)];
    [_bgV setImage:[UIImage imageNamed:@"historyBGImage"]];
    
    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_size.width, Screen_size.height - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    
    _tableV.backgroundView=_bgV;
    _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];

}

- (void)readData
{
    _dataSource = [[NSMutableArray alloc] init];
    LSSDBManager* manager = [LSSDBManager defaultDBManager];
    [manager allMessage];
    [_dataSource addObjectsFromArray:[manager allMessage]];
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 320;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    LSSBabyHistoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LSSBabyHistoryTableViewCell" owner:self options:nil] lastObject];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    LSSMineBabyModel* mo = _dataSource[indexPath.row];
    cell.contentL.layer.cornerRadius = 15;
    cell.contentL.layer.masksToBounds = YES;
    cell.contentL.text = mo.babyContent;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.babyImageV.image = [UIImage imageWithData:mo.imageData];
    NSArray * array=[mo.babyDate componentsSeparatedByString:@"+"];
    cell.timeL.text=array[0];
    return cell;
}

@end
