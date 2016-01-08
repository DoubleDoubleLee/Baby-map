//
//  ITBaseViewController.m
//  Dgtle
//
//  Created by LiYonghui on 13-5-24.
//  Copyright (c) 2013年 InfoThinker. All rights reserved.
//

#import "SCABaseViewController.h"
#import "SCAHorizontalVelometer.h"
#import "AppDelegate.h"

@interface SCABaseViewController () {
    
    CGPoint _originTouchPoint;
    CGPoint _lastTouchPoint;
    UIPanGestureRecognizer *_panRecognizer;
    SCAHorizontalVelometer *_panVelometer;
}

@end

@implementation SCABaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _panVelometer = [[SCAHorizontalVelometer alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
- (void)enablePanGestureRecognizer {
    
    if (_panRecognizer == nil) {
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    }
    
    [self.view addGestureRecognizer:_panRecognizer];
}

- (void)disablePanGestureRecognizer {
    
    if (_panRecognizer == nil) {
        return;
    }
    
    [self.view removeGestureRecognizer:_panRecognizer];
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:self.view.window];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        beginRect = self.navigationController.view.frame;
        
        _originTouchPoint = point;
        _lastTouchPoint = point;
        
        [_panVelometer reset];
        [_panVelometer addPoint:point];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {

        _lastTouchPoint = point;
        [_panVelometer addPoint:point];
        
        CGPoint firstPoint = [_panVelometer firstPoint];
        
        float sx =  point.x - firstPoint.x;
        CGRect rect = beginRect;
        rect.origin.x = rect.origin.x + sx;
        self.navigationController.view.frame = rect;
        [self swipToMove:rect.origin animation:NO];
        
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        _lastTouchPoint = point;
        [self panGestureRecognizerEnded];
    }
}

- (void)panGestureRecognizerEnded {
    
    double swipeVelocity = [_panVelometer swipeVelocity];
    CGFloat offset = _lastTouchPoint.x - _originTouchPoint.x;
    if (abs(offset) > kSwipeMinOffset && swipeVelocity > kSwipeMinVelocity) {
        [self swipeToRight:YES];
    }
    else if ( abs(offset) > kSwipeMinOffset && -swipeVelocity > kSwipeMinVelocity) {
        [self swipeToLeft:YES];
    }else{
        [UIView animateWithDuration:0.2f animations:^{
            CGRect rect = self.navigationController.view.frame;
            rect.origin.x = -10.f;
            self.navigationController.view.frame = rect;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
                CGRect rect = self.navigationController.view.frame;
                rect.origin.x = 0.f;
                self.navigationController.view.frame = rect;
            }];
        }];
    }
}

#pragma mark -
#pragma mark swip

- (void)swipToMove:(CGPoint)_point animation:(BOOL)_animation{
    
}

- (void)swipeToRight:(BOOL)_animation{
//    info(@"swipeToRight.....");
}

- (void)swipeToCenter:(BOOL)_animation{
//    info(@"swipeToCenter.....");
}

- (void)swipeToLeft:(BOOL)_animation{
//    info(@"swipeToLeft.....");
}

@end
