//
//  LSSMyBabyViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSMyBabyViewController.h"

#import "LSSFavoriteViewController.h"
#import "LSSBabyHistoryViewController.h"
#import "SDImageCache.h"
@interface LSSMyBabyViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {

    UITableView* _tableV;
    UIImageView* _headerV;
    UIImageView* _bgV2;
    UIImageView* _bgV;
    UILabel* _label;
}
@end

@implementation LSSMyBabyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sc_navigationItem.title = @"我的宝宝";
    [self createUI];
}

- (void)createUI
{

    _bgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_size.width, (Screen_size.height - 64 - 49) / 2)];
    _bgV.backgroundColor = [UIColor clearColor];
    _bgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height - 64 - 49)];
    [_bgV2 setImage:[UIImage imageNamed:@"girl"]];

    _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_size.width, Screen_size.height) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorColor = [UIColor colorWithRed:1.000 green:0.493 blue:0.573 alpha:1.000];
    // 去除tableV下面多于线的方法
    _tableV.tableFooterView = [[UIView alloc] init];
    _tableV.tableHeaderView = _bgV;
    _tableV.backgroundView = _bgV2;

    [self.view addSubview:_tableV];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{

    return 60;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray* titles = @[ @"我的收藏", @"成长记录", @"清除缓存" ];
    NSArray* imageArr = @[ @"save", @"history", @"clean" ];
    //去除cell的点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];

    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row == 0) {
        LSSFavoriteViewController* favorite = [[LSSFavoriteViewController alloc] init];
        [self.navigationController pushViewController:favorite animated:YES];
    }
    else if (indexPath.row == 1) {
        LSSBabyHistoryViewController* babyHistory = [[LSSBabyHistoryViewController alloc] init];
        [self.navigationController pushViewController:babyHistory animated:YES];
    }
    else {
#warning 具体的实践方法

        UIAlertView* alertV = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清除图片缓存", @"清除数据缓存", nil];
        [alertV show];
    }
}
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (buttonIndex == 1) {
        [self removeImageCache];
    }
    else {
        [self removeDataCache];
    }
}
- (void)removeImageCache
{
    // NSLog(@"%@",NSHomeDirectory());
    // NSLog(@"%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
    MBProgressHUD* hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.detailsLabelText = @"缓存清理中...";

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {

        SDImageCache* cache = [SDImageCache sharedImageCache];
        [cache clearMemory];
        [cache clearDisk]; //清除所有
        [cache cleanDisk]; //清除过期

        hub.mode = MBProgressHUDModeText;
        hub.detailsLabelText = @"清理成功";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            // Do something...
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}
- (void)removeDataCache
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = @"清除缓存中...";
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        // 清除缓存
        NSString* cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];

        NSArray* files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSUInteger fileCount = [files count];
        //NSLog(@"files :%ld",[files count]);
        for (NSString* p in files) {
            NSError* error;
            NSString* path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }

        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = [NSString stringWithFormat:@"清除缓存文件%ld个!", (unsigned long)fileCount];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            // Do something...
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });

    });
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
