//
//  Advertisement.h
//  广告栏封装
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface Advertisement : UIView

/** 根据本地地址和每一个页面的大小来初始化 */

+ (instancetype)shareWithFrame:(CGRect)frame
                          Size:(CGSize)size
                    imagePaths:(NSArray*)imagePaths
                  timeInterval:(float)timeIntelval
               showPageControl:(BOOL)showPageControl;

/** 根据图片的url 来创建 */

+ (instancetype)shareWithFrame:(CGRect)frame
                          Size:(CGSize)size
                     imageUrls:(NSArray*)imageUrls
                  timeInterval:(float)timeIntelval
               showPageControl:(BOOL)showPageControl;




@end
