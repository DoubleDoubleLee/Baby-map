//
//  SCBarButtonItem.h
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import "SCNavigation.h"

typedef NS_ENUM(NSInteger, SCBarButtonItemStyle) {  // for future use
    SCBarButtonItemStylePlain,
    SCBarButtonItemStyleBordered,
    SCBarButtonItemStyleDone,
};

@interface SCBarButtonItem : NSObject

@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong, readonly) UIButton *button;

@property (nonatomic, assign, getter = isEnabled) BOOL enabled;

- (instancetype)initWithTitle:(NSString *)title style:(SCBarButtonItemStyle)style handler:(void (^)(id sender))action;

- (instancetype)initWithImage:(UIImage *)image style:(SCBarButtonItemStyle)style handler:(void (^)(id sender))action;

- (instancetype)initWithCustomView:(UIView *)view;

@end
