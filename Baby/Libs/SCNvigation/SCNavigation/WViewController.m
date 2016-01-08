//
//  WViewController.m
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import "WViewController.h"

@interface WViewController ()
@property (nonatomic, assign) CGFloat dragOffsetY;

@end

@implementation WViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
	return self;
}

- (void)loadView{
	[super loadView];
	[self configNaviBar];
	
}

- (void)configNaviBar{
	if ((self.isRootVC || !self.sc_navigationBar.superview) && self.sc_navigationBar) {
		[self.view addSubview:self.sc_navigationBar];
		[self.sc_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(@0);
			make.right.equalTo(@0);
			make.top.equalTo(@0);
			make.height.equalTo(@WTopHeight);
		}];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	// Do any additional setup after loading the view.
	if (self.naviBarTitle) {
		self.sc_navigationItem.title = self.naviBarTitle;
	}
}

#pragma mark - Private Helper
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (!self.hiddenEnabled || scrollView.contentSizeHeight + scrollView.contentInsetTop < WScreenHeight) {
		return;
	}

	// Handle hidden
	CGFloat dragOffsetY = self.dragOffsetY - scrollView.contentOffsetY;
	
	CGFloat contentOffset = scrollView.contentOffsetY + scrollView.contentInsetTop;
	
	if (contentOffset < 43) {
		[self sc_setNavigationBarHidden:NO animated:YES];
		return;
	}

	if (dragOffsetY < - 30) {
		[self sc_setNavigationBarHidden:YES animated:YES];
		return;
	}
	
	if (dragOffsetY > 110) {
		[self sc_setNavigationBarHidden:NO animated:YES];
		return;
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	self.dragOffsetY = scrollView.contentOffsetY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

- (void)refreshData{
	
}

- (void)actSuccess{
	UIViewController *popedVC = [self.navigationController popViewControllerAnimated:YES];
	if (!popedVC) {
		[self dismissViewControllerAnimated:YES completion:^{
			
		}];
	}else {
		WViewController *lastVC = (WViewController *)[self.navigationController visibleViewController];
		if ([lastVC isKindOfClass:[WViewController class]]) {
			[lastVC refreshData];
		}
	}
}





//- (void)dealloc {
//	WLog(@"%@", NSStringFromClass([self class]));
//	[[NSNotificationCenter defaultCenter] removeObserver:self];
//}

@end
