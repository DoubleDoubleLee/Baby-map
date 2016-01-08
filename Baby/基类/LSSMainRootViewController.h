//
//  LSSMainRootViewController.h
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WViewController.h"
#import "MJRefresh.h"
@interface LSSMainRootViewController : WViewController <UITableViewDataSource, UITableViewDelegate,MyDelegate,MJRefreshBaseViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)UITableView* tableV;
@property(nonatomic,strong)UIScrollView * scrollV;
@property(nonatomic) NSInteger page;
@property(nonatomic,strong)MJRefreshFooterView * footer;
@property(nonatomic,strong)MJRefreshHeaderView *header;

-(void)loadData;
-(void)loadDataNextPage;
- (void)loadDataWithPath:(NSString*)path;
-(void)refreshData;
-(void)createUI;
@end
