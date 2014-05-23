//
//  RunProtocol.h
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RunDelegate <NSObject>

@required

- (id)generateAndGetResult;

@end
