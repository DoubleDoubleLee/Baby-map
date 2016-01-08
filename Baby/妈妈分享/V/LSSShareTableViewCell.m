//
//  LSSShareTableViewCell.m
//  Baby
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSShareTableViewCell.h"

@interface LSSShareTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView* imagevV;
@property (weak, nonatomic) IBOutlet UILabel* titleL;

@property (weak, nonatomic) IBOutlet UILabel* detailL;
@property (weak, nonatomic) IBOutlet UILabel* countL;

@end

@implementation LSSShareTableViewCell

- (void)setShareModel:(LSSMainModel*)shareModel
{
    _shareModel = shareModel;
    [_imagevV sd_setImageWithURL:[NSURL URLWithString:shareModel.imageUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    _titleL.text = shareModel.title;
    _detailL.text = shareModel.date;

    NSString* string = [shareModel.excerpt substringFromIndex:3];
    NSArray* array = [string componentsSeparatedByString:@"</p>"];
    _countL.text = array[0];
}

@end
