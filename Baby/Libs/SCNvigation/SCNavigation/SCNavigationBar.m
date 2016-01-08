//
//  SCNavigationBar.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import "SCNavigationBar.h"

@interface SCNavigationBar ()

@end

@implementation SCNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kNavigationBarColor;
		self.dynamic = NO;
		self.blurEnabled = NO;
		self.blurRadius = WBlurRadius;
		self.tintColor = kNavigationBarColor;
		self.updateInterval = 1.0 / 10;
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
