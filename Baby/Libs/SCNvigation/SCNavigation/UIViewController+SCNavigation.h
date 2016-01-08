//
//  SPViewController+NaviBar.h
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import "SCNavigationItem.h"
#import "SCBarButtonItem.h"
#import "EXTScope.h"

@class SCNavigationBar;

@interface UIViewController (SCNavigation)

/**
 *  导航栏上面的工具
 */
@property (nonatomic, strong) SCNavigationItem *sc_navigationItem;
/**
 *  导航条
 */
@property (nonatomic, strong) SCNavigationBar *sc_navigationBar;
/**
 *  导航条是否被隐藏
 */
@property(nonatomic, assign, getter = sc_isNavigationBarHidden) BOOL sc_navigationBarHidden;
/**
 *  是否是导航控制器的根控制器。(不用管这个属性)
 */
@property (nonatomic, assign) BOOL isRootVC;
/**
 *  设置导航条隐藏与否
 *
 *  @param hidden   是否隐藏
 *  @param animated 是否动画
 */
- (void)sc_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;
/**
 *  在导航条上面加上加载数据的动画
 */
- (void)naviBeginRefreshing;
- (void)naviEndRefreshing;

- (SCBarButtonItem *)createBackItem;

@end
