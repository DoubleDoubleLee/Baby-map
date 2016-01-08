//
//  WViewController.h
//  jianzhiweishi
//
//  Created by snow on 15/6/3.
//  Copyright (c) 2015年 yojianzhi. All rights reserved.
//

#import "UIViewController+SCNavigation.h"

@interface WViewController : UIViewController<UIScrollViewDelegate>

/**
 *  设置当页面中有 ScrollView 进行滑动时是否隐藏导航条
 */
@property (nonatomic, assign, getter = isHiddenEnabled) BOOL hiddenEnabled;

/**
 *  设置导航左边的按钮。（实际上可以设置控制器的 viewController.sc_navigationItem.leftBarButtonItem 属性）
 */
@property (nonatomic, strong) SCBarButtonItem *leftBarButtonItem;
/**
 *  设置导航右边的按钮。（实际上可以设置控制器的 viewController.sc_navigationItem.rightBarButtonItem 属性）
 */
@property (nonatomic, strong) SCBarButtonItem *rightBarButtonItem;
/**
 *  用法(block传值)
 *	self.rightBarButtonItem = [[SCBarButtonItem alloc] initWithTitle:@"发布" style:SCBarButtonItemStylePlain handler:^(id sender) {
 *		[self doSomeThing];//
 *	}];
 *	[self.rightBarButtonItem.button setTitleColor:WColorMain forState:UIControlStateNormal];
 *	self.sc_navigationItem.rightBarButtonItem = self.rightBarButtonItem;
 *
 *	也可以直接
 *	self.sc_navigationItem.rightBarButtonItem = [[SCBarButtonItem alloc] initWithTitle:@"发布" style:SCBarButtonItemStylePlain handler:^(id sender) {
 *		[self doSomeThing];//
 *	}];
 */

/**
 *  控制器的中心文字（实际上可以设置控制器的 viewController.sc_navigationItem.title 属性）
 *	如果使用这个属性，需要在 - (void)loadView 方法中使用。一般直接设置 sc_navigationItem.title 即可
 */
@property (nonatomic, strong) NSString *naviBarTitle;

- (void)refreshData;
- (void)actSuccess;

@end
