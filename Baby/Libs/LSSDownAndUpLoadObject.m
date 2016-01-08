//
//  LSSDownAndUpLoadObject.m
//  AFNetWorking的使用 self
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 Double Lee. All rights reserved.
//

#import "LSSDownAndUpLoadObject.h"
#import "AFNetworking.h"//必须包含第三方的头文件
@implementation LSSDownAndUpLoadObject

//将block嵌套到方法里面
//1.下载数据
+(void)downLoadDataType:(LSSDownLoadType)type Path:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSData *))success fail:(void (^)(NSError *))fail{
    //1.创建管理数据的请求对象
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    //2.设置请求的数据类型
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //3.不同方式的下载
    if (type==LSSDownLoadTypeGet) {
        [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            fail(error);
        }];
    }else if (type==LSSDownLoadTypePost){
        [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            fail(error);
        }];
    }else{
        return;
    }
}
//2.上传数据
+(void)upLoadDataWithPath:(NSString *)path parameters:(NSDictionary *)parameters key:(NSString *)key WithSource:(NSString*)source success:(void (^)(NSData *))success fail:(void (^)(NSError *))fail{//添加参数 : 后台需要的文件的key  和需要上传的数据source
    
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //参数:1.请求的资源地址  2.请求参数(字典) 3.是下载成功的回调 block 4.是下载失败的回调
    [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString * subPath=[[NSBundle mainBundle]pathForResource:source ofType:nil];
        NSString * terminalPath=[subPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
          //参数:1.需要上传文件的URL地址  2.表示后台需要的文件的key值,就是这个文件对应的参数名 3.表示文件在后台保存的名称 4.上传文件的类型  5.错误信息
        [formData appendPartWithFileURL:[NSURL URLWithString:terminalPath] name:key fileName:@"zidingyi" mimeType:@"image/jpeg" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error);
    }];
}

@end
