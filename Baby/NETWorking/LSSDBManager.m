//
//  LSSDBManager.m
//  SQL-Self
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 Double Lee. All rights reserved.
//

#import "LSSDBManager.h"

@implementation LSSDBManager {
    FMDatabase* _db; //创建数据库
    FMDatabase* _db2;
}
//创建单例类
+ (id)defaultDBManager
{
    static LSSDBManager* manager = nil;
    if (manager == nil) {
        manager = [[LSSDBManager alloc] init];
    }
    return manager;
}
//重写构造方法
- (id)init
{
    if ([super init]) {
        //在这个类创建之前 要保证数据库被创建且正常打开 表单也要被成功出来
        [self createDB];
        [self createTable];
    }
    return self;
}
#pragma mark--创建并打开数据库
- (void)createDB
{
    if (_db == nil) {
        NSString* path = NSHomeDirectory();
        NSString* dbPath = [path stringByAppendingPathComponent:@"Documents/Babys"];
        //  NSLog(@"%@",NSHomeDirectory());
        _db = [FMDatabase databaseWithPath:dbPath];
        //将数据库打开
        BOOL ret = [_db open];
        if (ret == YES) {
            NSLog(@"数据库打开成功");
        }
    }
#warning 创建第二个数据库
    if (_db2 == nil) {
        NSString* path = NSHomeDirectory();
        NSString* dbPath = [path stringByAppendingPathComponent:@"Documents/BabyHistory"];
        //  NSLog(@"%@",NSHomeDirectory());
        _db2 = [FMDatabase databaseWithPath:dbPath];
        //将数据库打开
        BOOL ret = [_db2 open];
        if (ret == YES) {
            NSLog(@"数据库2打开成功");
        }
    }
}
#pragma mark--创建表单
- (void)createTable
{
    //写sql语句
    NSString* sql = @"create table if not exists Babys (TITLE char(100),EXCERPT text, DATE integer,IMAGE text,CONTENTURL char(200));";
    //执行sql语句
    BOOL ret = [_db executeUpdate:sql];
    if (ret == YES) {
        NSLog(@"表单创建成功");
    }
    else {
        NSLog(@"表单创建失败");
    }

#warning 创建第二个表单
    //写sql语句
    NSString* sql2 = @"create table if not exists BabyHistory (CONTENT text, DATE integer,IMAGE text);";
    //执行sql语句
    BOOL ret2 = [_db2 executeUpdate:sql2];
    if (ret2 == YES) {
        NSLog(@"表单2创建成功");
    }
    else {
        NSLog(@"表单2创建失败");
    }
}
#pragma mark--增加数据
- (BOOL)addData:(LSSMainModel*)model
{
    //先查询数据
    NSString* searchSql = @"select * from Babys where TITLE=?;";
    FMResultSet* set = [_db executeQuery:searchSql, model.title];
    if (set.next == YES) {
        return nil;
    }

    NSString* sql = @"insert into Babys (TITLE,EXCERPT,DATE,IMAGE,CONTENTURL) values (?,?,?,?,?);";
    BOOL ret = [_db executeUpdate:sql, model.title, model.excerpt, model.date, model.imageUrl, model.contentUrl];
    if (ret == YES) {
        NSLog(@"插入数据成功");
        return YES;
    }
    else {
        NSLog(@"插入数据失败");
        return NO;
    }
}

#pragma mark--删除数据

- (void)deleteDatawithTitle:(NSString*)title
{
    NSString* sql = @"delete from Babys where TITLE=?;";
    BOOL ret = [_db executeUpdate:sql, title];
    if (ret == YES) {
        NSLog(@"删除数据成功");
    }
}
#pragma mark--查询数据
- (NSArray*)allData
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSString* sql = @"select * from Babys;";
    FMResultSet* set = [_db executeQuery:sql];
    //遍历这个数组
    while (set.next == YES) {
        NSString* title = [set stringForColumn:@"TITLE"];
        NSString* detail = [set stringForColumn:@"EXCERPT"];
        NSString* date = [set stringForColumn:@"DATE"];
        NSString* image = [set stringForColumn:@"IMAGE"];
        NSString* contentUrl = [set stringForColumn:@"CONTENTURL"];
        // NSString * count=[set stringForColumn:@"COUNT"];
        //提取模型
        LSSMainModel* mo = [[LSSMainModel alloc] init];
        mo.title = title;
        mo.excerpt = detail;
        mo.imageUrl = image;
        mo.date = date;
        mo.contentUrl = contentUrl;
        //   mo.parent=[NSNumber numberWithInteger:[count integerValue]];
        [array addObject:mo];
    }
    return array;
}
#warning 增加和读取第二个数据库
- (void)addMessage:(LSSMineBabyModel*)mo
{
    NSString* sql2 = @"insert into BabyHistory (CONTENT,DATE,IMAGE) values (?,?,?);";
    BOOL ret2 = [_db2 executeUpdate:sql2, mo.babyContent, mo.babyDate, mo.imageData];
    if (ret2 == YES) {
        NSLog(@"插入数据2成功");
    }
    else {
        NSLog(@"插入数据2失败");
    }
}
- (NSArray*)allMessage
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSString* sql2 = @"select * from BabyHistory;";
    FMResultSet* set2 = [_db2 executeQuery:sql2];
    while (set2.next == YES) {
        NSString* date = [set2 stringForColumn:@"DATE"];
        NSString* content = [set2 stringForColumn:@"CONTENT"];
        NSData* imageData = [set2 dataForColumn:@"IMAGE"];
        LSSMineBabyModel* mo = [[LSSMineBabyModel alloc] init];
        mo.babyContent = content;
        mo.imageData = [NSData dataWithData:imageData];
        mo.babyDate = date;
        [array addObject:mo];
    }
    return array;
}
@end
