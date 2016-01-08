//
//  LSSParseData.h
//  Baby
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 Double Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDelegate <NSObject>

- (void)sendData:(NSMutableArray*)array;
- (void)sendImageData:(NSMutableArray*)imageArr;

@end

@interface LSSParseData : NSObject

@property (nonatomic, assign) id<MyDelegate> delegate;

- (instancetype)init;

- (void)parseData:(NSString*)path;
- (void)parseShowData:(NSString*)path;

@end
