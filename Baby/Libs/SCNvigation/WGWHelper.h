//
//  WGWHelper.h
//  HuaRenJie
//
//  Created by snow on 15/7/3.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#ifndef HuaRenJie_WGWHelper_h
#define HuaRenJie_WGWHelper_h


//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import "FrameAccessor.h"

#define WMainPageDisapear @"WMainPageDisapear"

// appDelegate
#define WAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

// mainBundle
#define WMainBundle ([NSBundle mainBundle])

//-------------------获取设备大小-------------------------
// NavBar高度
#define WNavigationBarHeight (44.0)
// 状态栏高度
#define WStatusBarHeight (20)
// 顶部高度
#define WTopHeight (WNavigationBarHeight + WStatusBarHeight)
// 底部 TabBar 高度
#define WTabBarHeight 49
// 动态获取屏幕宽高
#define WScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define WScreenWidth ([UIScreen mainScreen].bounds.size.width)

#define WAnimationTime 0.25
#define WAlertViewShowTime 1.5

// 随机数
#define WArcNum(x) arc4random_uniform(x)
// 颜色
#define WColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define WColorRGB(r, g, b) WColorRGBA(r, g, b, 1.f)

// 随机颜色
#define WArcColor WColorRGB(WArcNum(128) + 128, WArcNum(128) + 128, WArcNum(128) + 128)
// 十六进制转颜色
#define WColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  标题文字颜色 透明度 0.85
 */
#define WColorFontTitle WColorRGB(38, 38, 38)
/**
 *  内容文字颜色 透明度 0.55
 */
#define WColorFontContent [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:0.55f]
/**
 *  细节文字颜色 透明度 0.35
 */
#define WColorFontDetail WColorRGB(166, 166, 166)
/**
 *  主要颜色(红)
 */
#define WColorMain WColorRGB(228, 102, 70)
/**
 *  辅助颜色(橙)
 */
#define WColorAssist [UIColor colorWithRed:1.000f green:0.541f blue:0.000f alpha:1.00f]
/**
 *  提醒颜色(红)
 */
#define WColorAlert [UIColor colorWithRed:0.890 green:0.165 blue:0.201 alpha:1.000]
/**
 *  背景颜色
 */

#define WColorBg WColorRGB(242, 243, 244)

/**
 *  线条颜色
 */
#define LINECOLOR  [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] 

/**
 *  导航条颜色
 */
#define WColorNavBg [UIColor colorWithRed:0.973f green:0.973f blue:0.973f alpha:1.00f]
/**
 *  浅灰色 透明度 0.05
 */
#define WColorLightGray [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:0.05f]
/**
 *  深灰色 透明度 0.20
 */
#define WColorDarkGray [UIColor colorWithRed:0.000f green:0.000f blue:0.000f alpha:0.20f]
/**
 *  自定义透明度白色
 */
#define WColorWihteA(x) [UIColor colorWithWhite:1.000 alpha:(x)]

// log
#define isShowLog 1
#if isShowLog
#define WLog(Format, ...) fprintf(stderr,"%s: %s->%d\n%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat:Format, ##__VA_ARGS__] UTF8String]);
#else
#define WLog(Format, ...)
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
