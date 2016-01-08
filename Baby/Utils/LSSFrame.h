//
//  LSSFrame.h
//  Baby
//
//  Created by qianfeng on 15/11/24.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSFrame : NSObject

@property(nonatomic,strong)LSSShowModel * showModel;

@property(nonatomic)CGRect headImage;
@property(nonatomic)CGRect nameL;
@property(nonatomic)CGRect detailL;
@property(nonatomic)CGRect contentL;
@property(nonatomic)CGRect timeL;
@property(nonatomic)CGRect imageV;

@property(nonatomic)CGFloat cellHeight;

@end
