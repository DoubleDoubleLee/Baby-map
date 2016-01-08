//
//  LSSDetailViewController.h
//  Baby
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "WViewController.h"
#import "LSSSearchViewController.h"
@interface LSSDetailViewController : LSSSearchViewController

@property(nonatomic,copy)NSString * content;
@property(nonatomic,strong) LSSMainModel * model;

@end
