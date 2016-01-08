//
//  ITHorizontalVelometer.m
//  Weibo2
//
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SCAHorizontalVelometer.h"

typedef enum {
    HorizontalVelocityDirectionLeft,
    HorizontalVelocityDirectionRight,
    HorizontalVelocityDirectionUnknown,
}HorizontalVelocityDirection;

@implementation SCAHorizontalVelometer
{
    NSMutableArray *_pointArray;
    NSMutableArray *_timeArray;
}

- (id)init
{
    self = [super init];
    if (self) {
        _pointArray = [[NSMutableArray alloc] init];
        _timeArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    SCASafeRelease(_pointArray);
    SCASafeRelease(_timeArray);
    SCASuperDealoc
}

#pragma mark -

- (CGPoint)firstPoint{
    return [_pointArray[0] CGPointValue];
}

- (void)addPoint:(CGPoint)p
{
    if ([_pointArray count] > 0) {
        CGPoint lastPoint = [[_pointArray lastObject] CGPointValue];
        if (p.x == lastPoint.x) {
            return;
        }
    }
    
    [_pointArray addObject:[NSValue valueWithCGPoint:p]];
    
    NSTimeInterval touchTime = [[NSDate date] timeIntervalSince1970];
    [_timeArray addObject:[NSNumber numberWithDouble:touchTime]];
}

- (void)reset
{
    [_pointArray removeAllObjects];
    [_timeArray removeAllObjects];
}

- (void)_getValidPointDistance:(float *)distance time:(double *)time
{
    HorizontalVelocityDirection swipeDirection = HorizontalVelocityDirectionUnknown;
    
    HorizontalVelocityDirection lastSwipeDirection = HorizontalVelocityDirectionUnknown;
    BOOL lastPointExist = NO;
    CGFloat lastPointX;
    NSUInteger validPointCounter = 0;
    
    for (NSValue *pointValue in [_pointArray reverseObjectEnumerator]) {
        
        CGPoint touchPoint = [pointValue CGPointValue];
        CGFloat thisPointX = touchPoint.x;
        if (lastPointExist == NO) {
            lastPointExist = YES;
            lastPointX = thisPointX;
            swipeDirection = HorizontalVelocityDirectionUnknown;
            validPointCounter += 1;
        } else {
            HorizontalVelocityDirection currentSwipeDirection;
            if (thisPointX >= lastPointX) {
                currentSwipeDirection = HorizontalVelocityDirectionLeft;
            } else {
                currentSwipeDirection = HorizontalVelocityDirectionRight;
            }
            
            swipeDirection = currentSwipeDirection;
            validPointCounter += 1;
            
            if (lastSwipeDirection != HorizontalVelocityDirectionUnknown && lastSwipeDirection != currentSwipeDirection) {
                validPointCounter -= 1;
                swipeDirection = lastSwipeDirection;
                break;
            }
            
            lastSwipeDirection = currentSwipeDirection;
            lastPointX = thisPointX;
        }
    }
    
    if (swipeDirection != HorizontalVelocityDirectionUnknown) {
        NSUInteger rangeLocation = [_pointArray count] - validPointCounter;
        NSArray *validPointArray = [_pointArray subarrayWithRange:NSMakeRange(rangeLocation, validPointCounter)];
        NSArray *validTimeArray = [_timeArray subarrayWithRange:NSMakeRange(rangeLocation, validPointCounter)];
        
        CGPoint firstCheckPoint = [[validPointArray objectAtIndex:0] CGPointValue];
        CGPoint lastCheckPoint = [[validPointArray objectAtIndex:[validPointArray count] - 1] CGPointValue];
        
        NSTimeInterval firstTime = [[validTimeArray objectAtIndex:0] doubleValue];
        NSTimeInterval lastTime = [[validTimeArray objectAtIndex:[validTimeArray count] - 1] doubleValue];
        
        *distance = lastCheckPoint.x - firstCheckPoint.x;
        *time = lastTime - firstTime;
        return;
    }
    
    *distance = 0.0;
    *time = 0.0;
}

- (double)swipeVelocity
{
    float distance;
    NSTimeInterval time;
    [self _getValidPointDistance:&distance time:&time];
    
    if (time == 0.0) {
        return 0.0;
    }
    
    return distance / time;
}

- (double)swipeVelocityPanDistance:(float *)panDistance
{
    NSTimeInterval time;
    [self _getValidPointDistance:panDistance time:&time];
    
    
    if (time == 0.0) {
        return 0.0;
    }
    
    return (*panDistance) / time;
}



@end
