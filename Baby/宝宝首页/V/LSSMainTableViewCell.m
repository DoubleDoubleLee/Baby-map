//
//  LSSMainTableViewCell.m
//  Baby
//
//  Created by qianfeng on 15/11/8.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSMainTableViewCell.h"

@interface LSSMainTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView* imageV;
@property (weak, nonatomic) IBOutlet UILabel* titleL;
@property (weak, nonatomic) IBOutlet UILabel* detailL;

@property (weak, nonatomic) IBOutlet UILabel* dateL;

@end

@implementation LSSMainTableViewCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)setModel:(LSSMainModel*)model
{
    _model = model;

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
    self.titleL.text = model.title;
    self.dateL.text = model.date;
    NSString* string = [model.excerpt substringFromIndex:3];
    NSArray* array = [string componentsSeparatedByString:@"</p>"];
    self.detailL.text = array[0];
}
@end
