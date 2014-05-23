//
//  ResultConsts.m
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "ResultConsts.h"

@implementation ResultConsts

@synthesize singletonData;

@synthesize count;

@synthesize resultArray;

static ResultConsts *shareManager = nil;

//获取单例实例
+ (ResultConsts *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        count = [NSNumber numberWithInt:0];
        resultArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)countPlusOne
{
    int c = [count intValue];
    c++;
    count = [NSNumber numberWithInt:c];
}

- (void)addOneResultToArray:(NSString *)resultStr
{
    NSMutableString *newResStr = [[NSMutableString alloc] initWithString:resultStr];
    [newResStr insertString:@" -" atIndex:17];
    [resultArray addObject:newResStr];
}


@end
