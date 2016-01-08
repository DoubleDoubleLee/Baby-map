//
//  LSSDownAndUpLoadObject.h
//  AFNetWorking的使用 self
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 Double Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSDownAndUpLoadObject : NSObject
//1.创建一个post/get方法的枚举
typedef NS_ENUM(NSInteger, LSSDownLoadType) {
    LSSDownLoadTypeGet,
    LSSDownLoadTypePost
};


//2.下载数据
+(void)downLoadDataType:(LSSDownLoadType)type Path:(NSString*)path parameters:(NSDictionary*)parameters success:(void(^)(NSData*data))success fail:(void(^)(NSError*error))fail;

//3.上传文件
+(void)upLoadDataWithPath:(NSString*)path parameters:(NSDictionary*)parameters key:(NSString*)key WithSource:(NSString*)source success:(void(^)(NSData*data))success fail:(void(^)(NSError*error))fail;

@end
