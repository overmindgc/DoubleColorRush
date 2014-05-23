//
//  CommonUtils.h
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-23.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
