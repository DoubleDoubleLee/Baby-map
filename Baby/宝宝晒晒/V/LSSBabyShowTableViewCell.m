//
//  LSSBabyShowTableViewCell.m
//  Baby
//
//  Created by qianfeng on 15/11/12.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSBabyShowTableViewCell.h"

@interface LSSBabyShowTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView* headImageV;
@property (weak, nonatomic) IBOutlet UILabel* nameL;
@property (weak, nonatomic) IBOutlet UILabel* detailL;
@property (weak, nonatomic) IBOutlet UILabel* contentL;
@property (weak, nonatomic) IBOutlet UIImageView* imageV;
@property (weak, nonatomic) IBOutlet UILabel* timeL;

@end

@implementation LSSBabyShowTableViewCell

- (void)updateCellWithModel:(LSSShowModel*)model
{
    self.headImageV.layer.cornerRadius = 25;
  //  self.headImageV.height=model.heigth;
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:model.creatorHeadPic] placeholderImage:[UIImage imageNamed:@"avatar"]];
    self.nameL.text = model.creatorNickName;
    self.detailL.text = [NSString stringWithFormat:@"%@·%@", model.city, model.region];

    [self expireDatetimeSinceNow:[NSString stringWithFormat:@"%@", model.photoTime]];

#warning <NULL>
    //    NSLog(@"%@",[model.content class]);
    if ([model.content class] == [NSNull class]) {
        self.contentL.text = [NSString stringWithFormat:@"%@。", model.text];
    }
    else {
        self.contentL.text = [NSString stringWithFormat:@"%@。%@。", model.text, model.content];
    }
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"avatar"]];
}
#pragma mark---时间字符串的转换
- (void)expireDatetimeSinceNow:(NSString*)time
{
    //把字符串按照给定的格式转化成data
    NSDateFormatter* expireFormat = [[NSDateFormatter alloc] init];
    //自定义时间格式
    expireFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss.S";
    //根据给定的格式把字符串转成date对象 dateFromString
    NSDate* expireDate = [expireFormat dateFromString:time];
    //当前时间 获取的是格林尼治时间 我们所在的区是东八区 早8个小时
    NSDate* currentDate = [NSDate date];
    //获取时间差
    NSTimeInterval interval = [expireDate timeIntervalSinceDate:currentDate];
    //计算时间和当前的时间差
    NSDateFormatter* showFormat = [[NSDateFormatter alloc] init];
    //用来显示时间的格式
    showFormat.dateFormat = @"HH:mm:ss";
    //剩余的时间
    NSDate* showDate = [NSDate dateWithTimeIntervalSinceNow:interval - 8 * 3600];
    //把NSDate对象转成字符串 stringFromDate
    NSString* dateStr = [showFormat stringFromDate:showDate];
    self.timeL.text = dateStr;
}

@end
