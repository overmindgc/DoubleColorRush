//
//  ResultViewController.h
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-23.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UILabel *countLabel;

@property NSMutableArray *tableListItems;

@end
