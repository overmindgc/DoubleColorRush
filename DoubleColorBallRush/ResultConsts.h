//
//  ResultConsts.h
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultConsts : NSObject

+ (ResultConsts *)sharedManager;

@property NSString* singletonData;

@property NSNumber* count;

@property NSMutableArray *resultArray;

- (void)countPlusOne;

- (void)addOneResultToArray:(NSString *)resultStr;

@end
