//
//  LSSParseData.m
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import "LSSParseData.h"
@implementation LSSParseData {
    NSMutableArray* _dataArr;
    NSMutableArray* _imageArr;
}
- (instancetype)init
{
    if (self = [super init]) {

        _dataArr = [[NSMutableArray alloc] init];
        _imageArr = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parseData:(NSString*)path
{

    [LSSDownAndUpLoadObject downLoadDataType:LSSDownLoadTypeGet
        Path:path
        parameters:nil
        success:^(NSData* data) {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* posts = dict[@"posts"];
            for (NSDictionary* subDic in posts) {
                NSArray* attachments = subDic[@"attachments"];
                if (attachments.count == 0) {
                }
                else {

                    LSSMainModel* model = [[LSSMainModel alloc] init];
                    model.imageUrl = subDic[@"attachments"][0][@"url"];
                    model.title = subDic[@"title"];
                    model.date = subDic[@"date"];
                    model.contentUrl = subDic[@"url"]; //详情网站
                    model.excerpt = subDic[@"excerpt"];
                    model.parent = subDic[@"categories"][0][@"parent"];

                    [_imageArr addObject:model.imageUrl];
                    [_dataArr addObject:model];
                }
                
            }
            [self.delegate sendData:_dataArr];
            [self.delegate sendImageData:_imageArr];
            NSLog(@"数据下载成功");
        }
        fail:^(NSError* error) {
            NSLog(@"数据下载失败");
        }];
}
- (void)parseShowData:(NSString*)path
{
    [LSSDownAndUpLoadObject downLoadDataType:LSSDownLoadTypeGet
        Path:path
        parameters:nil
        success:^(NSData* data) {
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray* array = dict[@"data"];
            for (NSDictionary* subDic in array) {

                LSSShowModel* model = [[LSSShowModel alloc] init];

                model.creatorNickName = subDic[@"feed"][@"creatorNickName"];
                model.creatorHeadPic = subDic[@"feed"][@"creatorHeadPic"];
                model.imageUrl = subDic[@"feed"][@"imageUrl"];
                model.city = subDic[@"feed"][@"city"];
                model.region = subDic[@"feed"][@"region"];
                model.text = subDic[@"feed"][@"share"][@"text"];
                model.content = subDic[@"feed"][@"content"];
                model.photoTime = subDic[@"feed"][@"photoTime"];

                [_dataArr addObject:model];
            }
            [self.delegate sendData:_dataArr];

            NSLog(@"数据下载成功!");
        }
        fail:^(NSError* error) {
            NSLog(@"数据下载失败!");
        }];
}
@end
