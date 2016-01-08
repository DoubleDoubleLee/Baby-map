//
//  SCNavigationPopAnimation.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import "SCNavigationPopAnimation.h"
#import "SCNavigation.h"
#import "UIImage+Tint.h"

static const CGFloat kToBackgroundInitAlpha = 0.08;
@interface SCNavigationPopAnimation ()

@property (nonatomic, strong) UIView      *toBackgroundView;
@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) UIView      *naviContainView;

@end

@implementation SCNavigationPopAnimation

- (instancetype)init {
	if (self = [super init]) {
		
		self.toBackgroundView = [[UIView alloc] init];
		
		self.shadowImageView = [[UIImageView alloc] initWithFrame:(CGRect){-WPeddingWidth, 0, WPeddingWidth, WScreenHeight}];
		self.shadowImageView.image = [UIImage imageNamed:@"Navi_Shadow"];
		self.shadowImageView.alpha = 1.3;
		self.shadowImageView.contentMode = UIViewContentModeScaleToFill;
		
		self.maskImageView = [[UIImageView alloc] initWithFrame:(CGRect){0, 20, WScreenWidth, 44}];
		self.maskImageView.image = [[UIImage imageNamed:@"navi_mask"] imageWithTintColor:WColorMain];
		
		self.naviContainView = [[UIView alloc] initWithFrame:(CGRect){0, 0, WScreenWidth, 64}];
		self.naviContainView.backgroundColor = [UIColor colorWithRed:0.774 green:0.368 blue:1.000 alpha:0.810];
		
	}
	return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *fromViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	UIView *containerView = [transitionContext containerView];
	NSTimeInterval duration = [self transitionDuration:transitionContext];
	
	toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
	[containerView addSubview:fromViewController.view];
	[containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
	[containerView insertSubview:self.toBackgroundView belowSubview:fromViewController.view];
	[containerView insertSubview:self.shadowImageView belowSubview:fromViewController.view];
	[self.shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(@(-WPeddingWidth));
		make.top.bottom.equalTo(@0);
		make.width.equalTo(@(WPeddingWidth));
	}];
	
	fromViewController.view.frame = CGRectMake(0, 0, WScreenWidth, WScreenHeight);
	toViewController.view.frame = CGRectMake(-90, 0, WScreenWidth, WScreenHeight);
	self.toBackgroundView.frame = CGRectMake(-90, 0, WScreenWidth, WScreenHeight);
	
	self.toBackgroundView.backgroundColor = [UIColor blackColor];
	self.toBackgroundView.alpha = kToBackgroundInitAlpha;
	
	// Configure Navi Transition
	UIView *naviBarView;
	
	UIView *toNaviLeft;
	UIView *toNaviRight;
	UIView *toNaviTitle;
	
	UIView *fromNaviLeft;
	UIView *fromNaviRight;
	UIView *fromNaviTitle;
	
	if (fromViewController.sc_isNavigationBarHidden || toViewController.sc_isNavigationBarHidden) {
		;
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
		
		[naviBarView addSubview:self.maskImageView];
		
		[naviBarView addSubview:toNaviLeft];
		[naviBarView addSubview:toNaviRight];
		
		[naviBarView addSubview:fromNaviLeft];
		[naviBarView addSubview:fromNaviRight];
		
		[self.maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.equalTo(naviBarView);
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
			make.bottom.equalTo(naviBarView.mas_bottom).offset(-1);
		}];
		
		[toNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(@(-WScreenWidth / 2));
			make.centerY.equalTo(naviBarView.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		[fromNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(naviBarView);
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
		fromNaviLeft.transform = CGAffineTransformIdentity;
		fromNaviRight.transform = CGAffineTransformIdentity;
		
		toNaviLeft.alpha = 0.0;
		toNaviRight.alpha = 0.0;
		toNaviTitle.alpha = 0.0;
		toNaviLeft.transform = CGAffineTransformMakeScale(0.1, 0.1);
		toNaviRight.transform = CGAffineTransformMakeScale(0.1, 0.1);
	}
	
	[containerView setNeedsUpdateConstraints];
	[containerView updateConstraintsIfNeeded];
	
	[fromNaviTitle mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(@(WScreenWidth));
	}];
	[toNaviTitle mas_updateConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(@0);
	}];
	[self.shadowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(@(WScreenWidth - WPeddingWidth));
	}];
	
	// End configure
	[UIView animateWithDuration:duration animations:^{
		[containerView layoutIfNeeded];
		
		toViewController.view.x = 0;
		self.toBackgroundView.x = 0;
		fromViewController.view.x = WScreenWidth;
		
		self.shadowImageView.alpha = 0.3;
		
		self.toBackgroundView.alpha = 0.0;
		fromNaviLeft.alpha = 0;
		fromNaviRight.alpha = 0;
		fromNaviTitle.alpha = 0;
		
		fromNaviLeft.transform = CGAffineTransformMakeScale(0.1, 0.1);
		fromNaviRight.transform = CGAffineTransformMakeScale(0.1, 0.1);
		
		toNaviLeft.alpha = 1.0;
		toNaviRight.alpha = 1.0;
		toNaviTitle.alpha = 1.0;
		
		toNaviLeft.transform = CGAffineTransformIdentity;
		toNaviRight.transform = CGAffineTransformIdentity;
	} completion:^(BOOL finished) {
		
		if (transitionContext.transitionWasCancelled) {
			toNaviLeft.alpha = 1.0;
			toNaviRight.alpha = 1.0;
			toNaviTitle.alpha = 1.0;
			toNaviLeft.transform = CGAffineTransformIdentity;
			toNaviRight.transform = CGAffineTransformIdentity;
			self.toBackgroundView.alpha = kToBackgroundInitAlpha;
		}
		
		[transitionContext completeTransition:!transitionContext.transitionWasCancelled];
		
		[naviBarView removeFromSuperview];
		[self.maskImageView removeFromSuperview];
		[self.toBackgroundView removeFromSuperview];
		[self.shadowImageView removeFromSuperview];
		[self.naviContainView removeFromSuperview];
		
		[toNaviLeft removeFromSuperview];
		[toNaviTitle removeFromSuperview];
		[toNaviRight removeFromSuperview];
		
		[fromNaviLeft removeFromSuperview];
		[fromNaviTitle removeFromSuperview];
		[fromNaviRight removeFromSuperview];
		
		[toViewController.sc_navigationBar addSubview:toNaviTitle];
		[toNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(toViewController.sc_navigationBar.mas_centerX);
			make.centerY.equalTo(toViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		[fromViewController.sc_navigationBar addSubview:fromNaviTitle];
		[fromNaviTitle mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(fromViewController.sc_navigationBar.mas_centerX);
			make.centerY.equalTo(fromViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		
		[toViewController.sc_navigationBar addSubview:toNaviLeft];
		[toViewController.sc_navigationBar addSubview:toNaviRight];
		
		[fromViewController.sc_navigationBar addSubview:fromNaviLeft];
		[fromViewController.sc_navigationBar addSubview:fromNaviRight];
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
			
			[fromNaviRight mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.equalTo(WRightPedding);
				make.centerY.equalTo(fromViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
			}];
			[fromNaviLeft mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.equalTo(@0);
				make.centerY.equalTo(fromViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
			}];
			[toNaviLeft mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.equalTo(@0);
				make.centerY.equalTo(toViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
			}];
			[toNaviRight mas_makeConstraints:^(MASConstraintMaker *make) {
				make.right.equalTo(WRightPedding);
				make.centerY.equalTo(toViewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
			}];
		}
	}];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
	return 0.3;
}

@end
