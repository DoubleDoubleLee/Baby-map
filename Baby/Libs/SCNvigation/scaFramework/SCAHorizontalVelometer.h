//
//  ITHorizontalVelometer.h
//  Weibo2
//
//  Created by 汉杰 许 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCAHorizontalVelometer : NSObject

- (void)addPoint:(CGPoint)p;
- (void)reset;
- (double)swipeVelocity;
- (double)swipeVelocityPanDistance:(float *)panDistance;
- (CGPoint)firstPoint;
@end
