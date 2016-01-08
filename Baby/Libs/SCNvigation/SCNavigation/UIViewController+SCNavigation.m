//
//  SPViewController+NaviBar.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//


static char const * const kNaviHidden = "kSPNaviHidden";
static char const * const kNaviBar = "kSPNaviBar";
static char const * const kNaviBarView = "kNaviBarView";
static char const * const kRootVC = "isRootVC";

#import <objc/runtime.h>

#import "UIViewController+SCNavigation.h"
#import "SCNavigation.h"

@implementation UIViewController (SCNavigation)

@dynamic isRootVC;
@dynamic sc_navigationItem;
@dynamic sc_navigationBar;
@dynamic sc_navigationBarHidden;

- (BOOL)sc_isNavigationBarHidden {
    return [objc_getAssociatedObject(self, kNaviHidden) boolValue];
}
- (void)setSc_navigationBarHidden:(BOOL)sc_navigationBarHidden {
    objc_setAssociatedObject(self, kNaviHidden, @(sc_navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isRootVC {
	return [objc_getAssociatedObject(self, kRootVC) boolValue];
}
- (void)setIsRootVC:(BOOL)isRootVC {
	objc_setAssociatedObject(self, kRootVC, @(isRootVC), OBJC_ASSOCIATION_ASSIGN);
}

- (void)sc_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden) {
		if (!self.sc_navigationBar.blurEnabled) {
			return;
		}
		self.sc_navigationBar.blurEnabled = NO;
		self.sc_navigationBar.dynamic = NO;
		[self.sc_navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(@-64);
		}];
		if (animated) {
			[UIView animateWithDuration:WAnimationTime * 2 animations:^{
				[self.sc_navigationBar layoutIfNeeded];
				for (UIView *view in self.sc_navigationBar.subviews) {
					view.alpha = 0.0;
				}
			} completion:^(BOOL finished) {
				self.sc_navigationBarHidden = YES;
			}];
		}else {
			[self.sc_navigationBar layoutIfNeeded];
			self.sc_navigationBarHidden = YES;
		}
    } else {
		[self.sc_navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(@0);
		}];
		if (animated) {
			
			[UIView animateWithDuration:WAnimationTime * 2 animations:^{
				[self.sc_navigationBar layoutIfNeeded];
				for (UIView *view in self.sc_navigationBar.subviews) {
					view.alpha = 1.0;
				}
			} completion:^(BOOL finished) {
				self.sc_navigationBarHidden = NO;
				self.sc_navigationBar.blurEnabled = YES;
				self.sc_navigationBar.dynamic = YES;
			}];
		}else {
			[self.sc_navigationBar layoutIfNeeded];
			self.sc_navigationBarHidden = NO;
			self.sc_navigationBar.blurEnabled = YES;
			self.sc_navigationBar.dynamic = YES;
		}
    }
}

- (SCNavigationItem *)sc_navigationItem {
    return objc_getAssociatedObject(self, kNaviBar);
}

- (void)setSc_navigationItem:(SCNavigationItem *)sc_navigationItem {
    objc_setAssociatedObject(self, kNaviBar, sc_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)sc_navigationBar {
    return objc_getAssociatedObject(self, kNaviBarView);
}

- (void)setSc_navigationBar:(UIView *)sc_navigationBar {
    objc_setAssociatedObject(self, kNaviBarView, sc_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)naviBeginRefreshing {

	NSInteger WActivityViewWidth = 35;
	
    UIActivityIndicatorView *activityView;
    for (UIView *view in self.sc_navigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
        if ([view isEqual:self.sc_navigationItem.rightBarButtonItem.view]) {
            [view removeFromSuperview];
        }
    }

    if (!activityView) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView setColor:[UIColor blackColor]];
        [self.sc_navigationBar addSubview:activityView];
		[activityView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.width.equalTo(@(WActivityViewWidth));
			make.height.equalTo(@(WActivityViewWidth));
			make.top.equalTo(@(WStatusBarHeight + (WNavigationBarHeight - WActivityViewWidth) / 2));
			make.right.equalTo(@(-WPeddingWidth));
		}];
    }

    [activityView startAnimating];

}


- (void)naviEndRefreshing {

    UIActivityIndicatorView *activityView;
    for (UIView *view in self.sc_navigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
    }
    if (self.sc_navigationItem.rightBarButtonItem) {
        [self.sc_navigationBar addSubview:self.sc_navigationItem.rightBarButtonItem.view];
    }
    [activityView stopAnimating];
}

- (SCBarButtonItem *)createBackItem {
	@weakify(self);
	return [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back_n"] style:SCBarButtonItemStyleDone handler:^(id sender) {
		@strongify(self);
		if (![self.navigationController popViewControllerAnimated:YES]) {
			[self dismissViewControllerAnimated:YES completion:nil];
		}
	}];
}

@end
