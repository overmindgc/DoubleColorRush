//
//  DoubleColorRunBL.m
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "DoubleColorRunBL.h"

@implementation DoubleColorRunBL
{
    NSArray *blueBallPool;
}

- (id)init
{
    self = [super init];
    if (self) {
        //初始红球池
        numPool = [[NSArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33", nil];
        //初始蓝球池
        blueBallPool = [[NSArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16", nil];
    }
    return self;
}

- (id)generateAndGetResult
{
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    //生成红球
    NSMutableArray *redBallArr = [[NSMutableArray alloc] init];
    NSMutableArray *tempRedBallPool = [NSMutableArray arrayWithArray:numPool];
    for (int i = 0; i < 6; i++) {
        int redIndex = arc4random() % tempRedBallPool.count;
        id redBall = [tempRedBallPool objectAtIndex:redIndex];
        [redBallArr addObject:redBall];
        [tempRedBallPool removeObject:redBall];
    }
    
    //排序
    NSArray *sortedArr = [redBallArr sortedArrayUsingSelector:@selector(compare:)];
    [resultStr appendString:[sortedArr componentsJoinedByString:@" "]];
    
    //生成蓝球
    int blueIndex = arc4random() % 16;
    id blueBall = [blueBallPool objectAtIndex:blueIndex];
    [resultStr appendString:@" "];
    [resultStr appendString:blueBall];
    
    return resultStr;
}

@end
