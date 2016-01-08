//
//  SCNavigationController.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//


#import "SCNavigationController.h"

#import "SCNavigationPopAnimation.h"
#import "SCNavigationPushAnimation.h"

#import "SCNavigation.h"

#import "CWStackPanGestureRecognizer.h"

@interface SCNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) CWStackPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic, assign) UIViewController *lastViewController;

@end

@implementation SCNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.enableInnerInactiveGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
	self.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
	self.interactivePopGestureRecognizer.delegate = nil;
	self.interactivePopGestureRecognizer.enabled = NO;
    super.delegate = self;
	
    self.panRecognizer = [[CWStackPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
	[self.view addGestureRecognizer:self.panRecognizer];
	[self.panRecognizer setDelegate:self];
}

#pragma mark - UINavigationDelegate
// forbid User VC to be NavigationController's delegate
- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate {
	
}

#pragma mark - Push & Pop
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	[self configureNavigationBarForViewController:viewController];
	[super pushViewController:viewController animated:animated];
}

//- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    return [super popToViewController:viewController animated:animated];
//}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    [viewController.view bringSubviewToFront:viewController.sc_navigationBar];
}

// Animation
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop && navigationController.viewControllers.count >= 1) {
        return [[SCNavigationPopAnimation alloc] init];
    }else if (operation == UINavigationControllerOperationPush) {
        return [[SCNavigationPushAnimation alloc] init];
    }else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[SCNavigationPopAnimation class]]) {
        return self.interactivePopTransition;
    }else {
        return nil;
    }
}

- (void)handlePanRecognizer:(CWStackPanGestureRecognizer *)recognizer {

	if (recognizer.direction == CWStackPanGestureRecognizerDirectionRight) {
		static CGFloat startLocationX = 0;
		
		CGPoint location = [recognizer locationInView:self.view];
		
		CGFloat progress = (location.x - startLocationX) / WScreenWidth;
		progress = MIN(1.0, MAX(0.0, progress));
		
		if (recognizer.state == UIGestureRecognizerStateBegan) {
			startLocationX = location.x;
			self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
			[self popViewControllerAnimated:YES];
		}else if (recognizer.state == UIGestureRecognizerStateChanged) {
			[self.interactivePopTransition updateInteractiveTransition:progress];
		}else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
			if (progress > 0.3) {
				self.interactivePopTransition.completionSpeed = 0.4;
				[self.interactivePopTransition finishInteractiveTransition];
			}else {
				self.interactivePopTransition.completionSpeed = 0.3;
				[self.interactivePopTransition cancelInteractiveTransition];
			}
			self.interactivePopTransition = nil;
		}
	}
}

- (void)configureNavigationBarForViewController:(UIViewController *)viewController {
	if (!viewController.sc_navigationItem) {
		SCNavigationItem *navigationItem = [[SCNavigationItem alloc] init];
		[navigationItem setValue:viewController forKey:@"_sc_viewController"];
		viewController.sc_navigationItem = navigationItem;
	}
	if (!viewController.sc_navigationBar) {
		viewController.sc_navigationBar = [[SCNavigationBar alloc] init];
	}
	if (!viewController.sc_navigationItem.leftBarButtonItem && !viewController.isRootVC) {
		viewController.sc_navigationItem.leftBarButtonItem = [viewController createBackItem];
	}
}

- (BOOL)gestureRecognizer:(CWStackPanGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
	if (([touch.view isKindOfClass:[UIButton class]] && ![(UIButton *)touch.view actionsForTarget:self.visibleViewController forControlEvent:UIControlEventTouchDragOutside]) || !self.enableInnerInactiveGesture) {
		return NO;
	}
	return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	UIView *otherView = otherGestureRecognizer.view;
	
	if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] && [otherView isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
		UITableView *otherTable = (UITableView *)otherView;
		if ([otherTable.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)] && [otherTable.delegate tableView:otherTable editingStyleForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] == UITableViewCellEditingStyleDelete) {
			return YES;
		}
	}else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"MMDrawerController")]) {
		return YES;
	}
	return NO;
}

@end
