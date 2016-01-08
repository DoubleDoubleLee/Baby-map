//
//  ITBaseViewController.h
//  Dgtle
//
//  Created by LiYonghui on 13-5-24.
//  Copyright (c) 2013年 InfoThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSwipeViewVisibleWidth          40.0f
#define kSwipeViewAnimateTime           0.16f
#define kSwipeMinOffset                 60.0f

//滑动速度 (point per second)
#define kSwipeMinVelocity               300.0f

@interface SCABaseViewController : UIViewController {
    CGRect beginRect;
}

- (void)enablePanGestureRecognizer;
- (void)disablePanGestureRecognizer;
- (void)swipeToRight;
- (void)swipeToLeft;
- (void)swipToMove:(CGPoint)_point;
@end
