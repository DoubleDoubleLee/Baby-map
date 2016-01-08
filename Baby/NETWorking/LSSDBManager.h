//
//  LSSDBManager.h
//  SQL-Self
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 Double Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LSSMainModel.h"
@interface LSSDBManager : NSObject
//创建单例类
+ (id)defaultDBManager;
//模型数据
//增加数据
//-(void)addData:(LSSMainModel*)model;
////删除数据
//-(void)deleteData:(LSSMainModel*)model withTitle:(NSString*)title;
////修改数据
//-(void)changeData:(LSSMainModel*)model withTitle:(NSString*)title;
//查找数据
- (NSArray*)allData;
- (BOOL)addData:(id)model;
- (void)deleteDatawithTitle:(NSString*)title;

//第二个数据库
-(void)addMessage:(id)mo;
-(NSArray *)allMessage;

@end
