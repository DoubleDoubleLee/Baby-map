//
//  LSSShowModel.h
//  Baby
//
//  Created by qianfeng on 15/11/12.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSShowModel : NSObject

Pro_Str babyNickName;//宝宝名字
Pro_Str city;
Pro_Str region;//拼接地址 会出现空值
Pro_Str creatorHeadPic;//妈妈头像
Pro_Str creatorNickName;//妈妈名字
Pro_Str imageUrl;//分享的图片
Pro_Num photoTime; //上传时间
Pro_Str text;//分享内容
Pro_Str content;//拼接内容 会出现空值



@end
