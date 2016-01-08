//
//  LSSBabyShowTableViewCell.h
//  Baby
//
//  Created by qianfeng on 15/11/12.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSSShowModel;
@interface LSSBabyShowTableViewCell : UITableViewCell
//刷新cell
-(void)updateCellWithModel:(LSSShowModel*)model;


@end
