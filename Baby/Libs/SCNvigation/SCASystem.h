//
//  SCASystem.h
//  milk
//
//  Created by JerryChan on 13-3-14.
//  Copyright (c) 2013年 JerryChan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>


#import <TargetConditionals.h>


#if ! __has_feature(objc_arc)

    // -fno-objc-arc
    #define SCAAutorelease(__v) ([__v autorelease]);
    #define SCAReturnAutoreleased SCAAutorelease

    #define SCARetain(__v) ([__v retain]);
    #define SCAReturnRetained SCARetain

    #define SCARelease(__v) ([__v release]);
    #define SCASafeRelease(__v) ([__v release], __v = nil);
    #define SCASuperDealoc [super dealloc];

    #define SCAWeak

#else

    // -fobjc-arc
    #define SCAAutorelease(__v)
    #define SCAReturnAutoreleased(__v) (__v)

    #define SCARetain(__v)
    #define SCAReturnRetained(__v) (__v)

    #define SCARelease(__v)
    #define SCASafeRelease(__v) (__v = nil);
    #define SCASuperDealoc

    #define SCAWeak __weak

#endif

// 随机生成颜色
CG_EXTERN UIColor * randomColor();

typedef void (^ SCABlock)(id __result, NSError *__error);

@interface SCASystem : NSObject {}

#pragma mark - create singleton object

+ (id)share;
+ (void)destory;

#pragma mark - system io method

+ (NSString *)pathWithDocuments;
+ (NSString *)tmpWithDocuments;

+ (BOOL)mkdir:(NSString *)_path;
+ (BOOL)mkfile:(NSString *)_path;

+ (void)appendDataWithFile:(NSString *)_path data:(NSData *)_data;
+ (void)writeDataWithFile:(NSString *)_path data:(NSData *)_data;

+ (NSArray *)filesArrayWithPath:(NSString *)_path;
+ (NSDictionary *)readPlist:(NSString *)_path;

+ (BOOL) rm:(NSString *)_filePath;
+ (BOOL) copyFileAtURL:(NSString *)_targetPath toURL:(NSString *)_toPath;

#pragma mark - system network method

+ (NSString *)macAddress;

+ (NSString *)deviceName;
+ (NSString *)deviceSystemVersion;
+ (NSString *)systemVersion;

#pragma mark - system utils method

+ (NSString *)md5:(NSString *)_str;
+ (NSString *)onlyID;

+ (NSString *)getLanguage;
+ (unsigned int) systemVersionInt;

+ (NSString *) stringByDate:(int)_date;

@end

