//
//  SCNavigationItem.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import "SCNavigationItem.h"
#import "SCNavigation.h"

@interface SCNavigationItem ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, assign) UIViewController *_sc_viewController;

@end

@implementation SCNavigationItem

- (instancetype)init {
    if (self = [super init]) {
		
    }
    return self;
}

- (void)setTitle:(NSString *)title {

    _title = title;

    if (!title) {
        _titleLabel.text = @"";
        return;
    }

    if ([title isEqualToString:_titleLabel.text]) {
        return;
    }

    if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		[_titleLabel sizeToFit];
		[_titleLabel setFont:[UIFont boldSystemFontOfSize:KNavigationBarTitleFont]];
        [_titleLabel setTextColor:kNavigationBarTintColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [__sc_viewController.sc_navigationBar addSubview:_titleLabel];
		[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.width.lessThanOrEqualTo(WScreenWidth - 100);
			make.centerX.equalTo(__sc_viewController.sc_navigationBar.mas_centerX);
			make.centerY.equalTo(__sc_viewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
		_titleView = _titleLabel;
    }

    _titleLabel.text = title;
}

- (void)setLeftBarButtonItem:(SCBarButtonItem *)leftBarButtonItem {
    if (__sc_viewController) {
        [_leftBarButtonItem.view removeFromSuperview];
        [__sc_viewController.sc_navigationBar addSubview:leftBarButtonItem.view];
		[leftBarButtonItem.view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@0);
			make.centerY.equalTo(__sc_viewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
    }

    _leftBarButtonItem = leftBarButtonItem;
}

- (void)setRightBarButtonItem:(SCBarButtonItem *)rightBarButtonItem {

    if (__sc_viewController) {
        [_rightBarButtonItem.view removeFromSuperview];
		[__sc_viewController.sc_navigationBar addSubview:rightBarButtonItem.view];
		[rightBarButtonItem.view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.equalTo(WRightPedding);
			make.centerY.equalTo(__sc_viewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
		}];
    }

    _rightBarButtonItem = rightBarButtonItem;
}

- (void)setTitleView:(UIView *)titleView {
	[_titleLabel removeFromSuperview];
	_titleLabel = nil;
	_title = nil;
    CGSize size = titleView.frame.size;
	if (__sc_viewController) {
		[__sc_viewController.sc_navigationBar addSubview:titleView];
		[titleView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.equalTo(__sc_viewController.sc_navigationBar.mas_centerY).offset(WStatusBarHeight / 2);
			make.centerX.equalTo(0);
            make.size.equalTo(size);
		}];
	}
	_titleView = titleView;
}

@end
