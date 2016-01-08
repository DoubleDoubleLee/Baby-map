//
//  LSSTabBarViewController.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSTabBarViewController.h"
#import "LSSMainViewController.h"
#import "LSSBabyShowViewController.h"
#import "LSSShareViewController.h"
#import "LSSMyBabyViewController.h"
#import "RDVTabBarItem.h"
@interface LSSTabBarViewController ()

@end

@implementation LSSTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addChildViewControllers];
    [self customizeTabBarForController:self];
}
- (void)addChildViewControllers
{
    LSSMainViewController* main = [[LSSMainViewController alloc] initWithNibName:@"LSSMainViewController" bundle:nil];
    SCNavigationController* mainNav = [[SCNavigationController alloc] initWithRootViewController:main];
    LSSBabyShowViewController* babyShow = [[LSSBabyShowViewController alloc] initWithNibName:@"LSSBabyShowViewController" bundle:nil];
    SCNavigationController* babyShowNav = [[SCNavigationController alloc] initWithRootViewController:babyShow];
    LSSShareViewController* share = [[LSSShareViewController alloc] initWithNibName:@"LSSShareViewController" bundle:nil];
    SCNavigationController* shareNav = [[SCNavigationController alloc] initWithRootViewController:share];
    LSSMyBabyViewController* myBaby = [[LSSMyBabyViewController alloc] initWithNibName:@"LSSMyBabyViewController" bundle:nil];
    SCNavigationController* myNav = [[SCNavigationController alloc] initWithRootViewController:myBaby];
    self.viewControllers = @[ mainNav, babyShowNav, shareNav, myNav ];
}
//实现导航条颜色的方法
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent; //设置tabBar的透明
}
//从RDVAppDelegate拷贝的代码
- (void)customizeTabBarForController:(RDVTabBarController*)tabBarController
{
    NSArray* titles = @[ @"宝宝主页", @"宝宝晒晒", @"妈妈分享", @"我的宝贝" ];
    NSArray* itemImages = @[ @"main", @"baby", @"discover", @"my" ];
    //设置字体
    NSDictionary* unselectedTitleAttributes = nil;
    NSDictionary* selectedTitleAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        unselectedTitleAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : WColorRGB(153, 169, 168) };

        selectedTitleAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : WColorRGB(248, 60, 100) };
    }
    NSInteger index = 0;
    for (RDVTabBarItem* item in [[tabBarController tabBar] items]) {
        item.title = titles[index];
        NSString* imageName = [NSString stringWithFormat:@"%@.png", itemImages[index]];
        NSString* selectedImageName = [NSString stringWithFormat:@"%@_press.png", itemImages[index]];
        UIImage* image = [UIImage imageNamed:imageName];
        UIImage* selectImage = [UIImage imageNamed:selectedImageName];
        //设置图片
        [item setFinishedSelectedImage:selectImage withFinishedUnselectedImage:image];
        //设置title字体大小和颜色
        item.unselectedTitleAttributes = unselectedTitleAttributes;
        item.selectedTitleAttributes = selectedTitleAttributes;

        index++;
    }
}

@end
