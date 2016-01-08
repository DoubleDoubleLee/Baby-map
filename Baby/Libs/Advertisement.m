//
//  Advertisement.m
//  广告栏封装
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Advertisement.h"

@interface Advertisement()<UIScrollViewDelegate>

/** scrollView */
@property(nonatomic,strong) UIScrollView *scrollView;

/**分页指示器 */
@property(nonatomic,strong) UIPageControl *pageControl;

/** 计时器 */
@property(nonatomic,strong) NSTimer *timer;

/** 每一个字视图的大小 */
@property(nonatomic,assign) CGSize size;
/** 放置本地地址的数组 */
@property(nonatomic,strong) NSArray *imagePaths;
/** 放置url的数组 */
@property(nonatomic,strong) NSArray *imageUrls;

/** 图片滚动的时间间隔 */
@property(nonatomic,assign) float timeIntelval;

/** 是否显示分页指示器 */
@property(nonatomic,assign) BOOL showPageControl;



@end

@implementation Advertisement

//根据本地文件的数组 来创建一个广告栏
+ (instancetype)shareWithFrame:(CGRect)frame Size:(CGSize)size imagePaths:(NSArray *)imagePaths timeInterval:(float)timeIntelval showPageControl:(BOOL)showPageControl{
    
    Advertisement * adverView = [[Advertisement alloc]initWithFrame:frame];
    adverView.size = size;
    adverView.timeIntelval = timeIntelval;
    adverView.showPageControl = showPageControl;
    adverView.imagePaths = imagePaths;
    /** 创建一个scrollView */
    [adverView scrollView];
    
    if (showPageControl) {
        [adverView pageControl];
    }
    return adverView;
    
}

+ (instancetype)shareWithFrame:(CGRect)frame Size:(CGSize)size imageUrls:(NSArray *)imageUrls timeInterval:(float)timeIntelval showPageControl:(BOOL)showPageControl{
    
    Advertisement *adverView = [[Advertisement alloc]initWithFrame:frame];
    adverView.size = size;
    adverView.showPageControl = showPageControl;
    adverView.timeIntelval = timeIntelval;
    adverView.imageUrls = imageUrls;
    
    /** 创建一个scrollView */
    [adverView scrollView];
    
    if (showPageControl) {
        [adverView pageControl];
    }
    return adverView;
    
    
}
/** 重写imagePaths的set方法 */
- (void)setImagePaths:(NSArray *)imagePaths{
    _imagePaths = imagePaths;
    //NSLog(@"%@",imagePaths);
    //    把新传入的视图添加到scrollView 上
    for (int i = 0 ; i < imagePaths.count + 2; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.size.width * i, 0, self.size.width, CGRectGetHeight(self.scrollView.frame))];
        
        NSString *path = nil;
        if (i == 0) {
            path = imagePaths.lastObject;
        }
        else if (i == imagePaths.count + 1) {
            path = imagePaths.firstObject;
        }
        else {
            path = imagePaths[i-1];
        }
        //        创建图片
        imageView.image = [UIImage imageNamed:path];
        
        [self.scrollView addSubview:imageView];
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
        
        
        
    }
    
    if (self.showPageControl) {
        //    设置pageControl
        //    pageControl 放在视图的最上层
        [self bringSubviewToFront:self.pageControl];
        //    设置pageControl 的个数
        self.pageControl.numberOfPages = imagePaths.count;
        //    设置当前的页数
        self.pageControl.currentPage = 1;
        //    设置当前页面的偏移量
        self.scrollView.contentOffset = CGPointMake(self.size.width, 0);
        
    }
    if (self.timeIntelval==0) {
        //为0的时候不自动滚动
        [self.timer setFireDate:[NSDate distantFuture]];
    }else{
        //    启动定时器 自动滚屏
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeIntelval]];
    }
}

/** 重写imageUrls的set方法 */
- (void)setImageUrls:(NSArray *)imageUrls{
    _imageUrls = imageUrls;
    
    self.imagePaths = imageUrls;
    for (int i = 0 ; i <imageUrls.count + 2; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.size.width * i, 0, self.size.width, CGRectGetHeight(self.scrollView.frame))];
        
        NSString *path = nil;
        if (i == 0) {
            path = imageUrls.lastObject;
        }
        else if (i == imageUrls.count + 1) {
            path = imageUrls.firstObject;
        }
        else {
            path = imageUrls[i-1];
        }
        // 根据第三方创建图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:path]];
        
        [self.scrollView addSubview:imageView];
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
        
        
    }
    
    if (self.showPageControl) {
        //    设置pageControl
        //    pageControl 放在视图的最上层
        [self bringSubviewToFront:self.pageControl];
        //    设置pageControl 的个数
        self.pageControl.numberOfPages = imageUrls.count;
        //    设置当前的页数
        self.pageControl.currentPage = 1;
        //    设置当前页面的偏移量
        self.scrollView.contentOffset = CGPointMake(self.size.width, 0);
        
        
    }
    if (self.timeIntelval==0) {
        //为0的时候不自动滚动
        [self.timer setFireDate:[NSDate distantFuture]];
    }else{
        //    启动定时器 自动滚屏
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeIntelval]];
    }
}


#pragma mark－－－－－－－－－－－－协议方法－－－－－－－－－－－－－

/** 减速完成(停止) */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setPageAndCircleWithScrollView:scrollView];
}

/** setContnetOffSet: animated:YES , 动画完成之后, 不会走减速的方法, 而是走这个方法 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self setPageAndCircleWithScrollView:scrollView];
}

/** 设置循环滚动与页码 */
//⚠️ 这个地方的imagePaths 的问题
- (void)setPageAndCircleWithScrollView:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / self.size.width;
    
    if (page == 0) {
        [scrollView setContentOffset:CGPointMake(self.size.width * (self.imagePaths.count), 0) animated:NO];
        self.pageControl.currentPage = self.imagePaths.count - 1;
    }
    else if (page == self.imagePaths.count + 1) {
        [scrollView setContentOffset:CGPointMake(self.size.width, 0) animated:NO];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = page - 1;
    }
}



#pragma mark ---------------懒加载---------------------
/**
 放置广告栏图片的scrollView
 */
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        
        //        重新创建一个scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        //        设置 分页
        _scrollView.backgroundColor = [UIColor colorWithRed:1.000 green:0.493 blue:0.573 alpha:1.000];
        
        _scrollView.pagingEnabled = YES;
        //        隐藏分页指示器
        _scrollView.showsHorizontalScrollIndicator = NO;
        //        设置代理，实现代理方法
        _scrollView.delegate = self;
        //        将新建的scrollView 添加到父视图上
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        
        //        添加到父视图上
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

/**
 时间控制器
 */
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeIntelval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        //设置计时器的开始执行时间   现在不执行
        [_timer setFireDate:[NSDate distantFuture]];
        
    }
    return _timer;
}

//时间控制起的 事件
- (void)timerAction{
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.size.width, 0) animated:YES];
}




@end
