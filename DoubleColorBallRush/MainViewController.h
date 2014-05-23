//
//  MainViewController.h
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunDelegate.h"

@interface MainViewController : UIViewController

@property NSTimer *runTimer;

@property id<RunDelegate> runBL;

- (void)startTimerRunWith:(float)speed;

- (void)stopTimerRun:(BOOL)forSave;

@end
