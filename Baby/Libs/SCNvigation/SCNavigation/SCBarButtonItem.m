//
//  SCBarButtonItem.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import "SCBarButtonItem.h"

@interface SCBarButtonItem ()

@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, copy) void (^actionBlock)(id);

@end

@implementation SCBarButtonItem

- (instancetype)init {

    if (self = [super init]) {
		
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title style:(SCBarButtonItemStyle)style handler:(void (^)(id sender))action {

    if ([self init]) {
		
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:KNavigationBarItemTitleFont]];
        [button setTitleColor:kNavigationBarTintColor forState:UIControlStateNormal];
        [button sizeToFit];
        button.height = WNavigationBarHeight;
//        button.width += 30;
        button.centerY = WStatusBarHeight + WNavigationBarHeight / 2.0;
        button.x = 0;
		_button = button;
        self.view = button;
		if (style == SCBarButtonItemStyleBordered) {
			button.layer.cornerRadius = 4.0f;
			button.layer.borderColor = [UIColor whiteColor].CGColor;
			button.layer.borderWidth = 0.5f;
			button.layer.masksToBounds = YES;
		}

        self.actionBlock = action;

        [button addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.height.greaterThanOrEqualTo(@32);
			make.width.greaterThanOrEqualTo(@48);
		}];
    }

    return self;
}

- (instancetype)initWithImage:(UIImage *)image style:(SCBarButtonItemStyle)style handler:(void (^)(id sender))action {

    if ([self init]) {

        self.buttonImage = image;

        UIButton *button = [[UIButton alloc] init];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        [button sizeToFit];
        button.centerY = WStatusBarHeight + WNavigationBarHeight / 2.0;
		_button = button;
        _view = button;

        self.actionBlock = action;

        [button addTarget:self action:@selector(handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(handleTouchDown:) forControlEvents:UIControlEventTouchDown];
		[button addTarget:self action:@selector(handleTouchUp:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.height.greaterThanOrEqualTo(@32);
			make.width.greaterThanOrEqualTo(@48);
		}];
    }

    return self;
}

- (instancetype)initWithCustomView:(UIView *)view{
	if ([self init]) {
		view.height = WNavigationBarHeight;
//		view.width += 30;
		view.centerY = WStatusBarHeight + WNavigationBarHeight / 2.0;
		_button = (UIButton *)view;
		self.view = view;
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.height.greaterThanOrEqualTo(@32);
			make.width.greaterThanOrEqualTo(@48);
		}];
	}
	
	return self;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;

    if (enabled) {
        self.view.userInteractionEnabled = YES;
        self.view.alpha = 1.0;
    } else {
        self.view.userInteractionEnabled = NO;
        self.view.alpha = 0.3;
    }

}

#pragma mark - Private Methods

- (void)handleTouchUpInside:(UIButton *)button {
	if (self.actionBlock) {
		self.actionBlock(button);
	}
    [UIView animateWithDuration:0.2 animations:^{
        button.alpha = 1.0;
    }];

}

- (void)handleTouchDown:(UIButton *)button {

    button.alpha = 0.3;

}

- (void)handleTouchUp:(UIButton *)button {

    [UIView animateWithDuration:0.3 animations:^{
        button.alpha = 1.0;
    }];

}

@end
