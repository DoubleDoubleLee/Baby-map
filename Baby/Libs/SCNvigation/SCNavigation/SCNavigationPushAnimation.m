//
//  SCNavigationPushAnimation.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//


#import "SCNavigationPushAnimation.h"
#import "SCNavigation.h"

@interface SCNavigationPushAnimation ()

@end

@implementation SCNavigationPushAnimation

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    fromViewController.view.frame = CGRectMake(0, 0, WScreenWidth, WScreenHeight);
    toViewController.view.frame = CGRectMake(WScreenWidth, 0, WScreenWidth, WScreenHeight);

    // Configure Navi Transition
    UIView *naviBarView;

    UIView *toNaviLeft;
    UIView *toNaviRight;
    UIView *toNaviTitle;

    UIView *fromNaviLeft;
    UIView *fromNaviRight;
    UIView *fromNaviTitle;

    if (fromViewController.sc_isNavigationBarHidden || toViewController.sc_isNavigationBarHidden) {
		if (fromViewController.sc_isNavigationBarHidden) {
			[toViewController.view bringSubviewToFront:toViewController.sc_navigationBar];
		}
	} else {
		naviBarView = [[SCNavigationBar alloc] init];
		[containerView addSubview:naviBarView];
		[naviBarView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@0);
			make.right.equalTo(@0);
			make.top.equalTo(@0);
			make.height.equalTo(@WTopHeight);
		}];

        toNaviLeft = toViewController.sc_navigationItem.leftBarButtonItem.view;
        toNaviRight = toViewController.sc_navigationItem.rightBarButtonItem.view;
        toNaviTitle = toViewController.sc_navigationItem.titleView;

        fromNaviLeft = fromViewController.sc_navigationItem.leftBarButtonItem.view;
        fromNaviRight = fromViewController.sc_navigationItem.rightBarButtonItem.view;
        fromNaviTitle = fromViewController.sc_navigationItem.titleView;
		
		[naviBarView addSubview:toNaviTitle];
		[naviBarView addSubview:fromNaviTitle];
		
		[naviBarView addSubview:toNaviLeft];
		[naviBarView addSubview:fromNaviLeft];
		
        [naviBarView addSubview:toNaviRight];
		[naviBarView addSubview:fromNaviRight];
		
		[toNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(@(WScreenWidth));
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		[fromNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(@0);
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		
		[toNaviLeft mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@0);
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		[fromNaviLeft mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@0);
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		
		[toNaviRight mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.equalTo(WRightPedding);
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		[fromNaviRight mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.equalTo(WRightPedding);
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		[naviBarView layoutIfNeeded];
		
        fromNaviLeft.alpha = 1.0;
        fromNaviRight.alpha =  1.0;
        fromNaviTitle.alpha = 1.0;

        toNaviLeft.alpha = 0.0;
        toNaviRight.alpha = 0.0;
        toNaviTitle.alpha = 0.0;
    }
    // End configure
	[containerView setNeedsUpdateConstraints];
	[containerView updateConstraintsIfNeeded];
	
	[fromNaviTitle mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(@(-WScreenWidth / 2));
	}];
	[toNaviTitle mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(@0);
	}];
	
    [UIView animateWithDuration:duration animations:^{
		[naviBarView layoutIfNeeded];
		
        toViewController.view.x = 0;
        fromViewController.view.x = -120;

        fromNaviLeft.alpha = 0;
        fromNaviRight.alpha =  0;
        fromNaviTitle.alpha = 0;
		
        toNaviLeft.alpha = 1.0;
        toNaviRight.alpha = 1.0;
        toNaviTitle.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];

        fromNaviLeft.alpha = 1.0;
        fromNaviRight.alpha = 1.0;
        fromNaviTitle.alpha = 1.0;
        
        [naviBarView removeFromSuperview];

        [toNaviLeft removeFromSuperview];
        [toNaviTitle removeFromSuperview];
        [toNaviRight removeFromSuperview];

        [fromNaviLeft removeFromSuperview];
        [fromNaviTitle removeFromSuperview];
        [fromNaviRight removeFromSuperview];
		
		[toViewController.sc_navigationBar addSubview:toNaviTitle];
		[fromViewController.sc_navigationBar addSubview:fromNaviTitle];
		[toViewController.sc_navigationBar addSubview:toNaviLeft];
		[fromViewController.sc_navigationBar addSubview:fromNaviLeft];
		[toViewController.sc_navigationBar addSubview:toNaviRight];
		[fromViewController.sc_navigationBar addSubview:fromNaviRight];
		
		[toNaviLeft mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@0);
			make.centerY.equalTo(toViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		
		[toNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(toViewController.sc_navigationBar.mas_centerX);
			make.centerY.equalTo(toViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		
		[toNaviRight mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.equalTo(WRightPedding);
			make.centerY.equalTo(toViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];

		[fromNaviLeft mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@0);
			make.centerY.equalTo(fromViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		
		[fromNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(fromViewController.sc_navigationBar.mas_centerX);
			make.centerY.equalTo(fromViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		
		[fromNaviRight mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.equalTo(WRightPedding);
			make.centerY.equalTo(fromViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
