//
//  ResultViewController.m
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-23.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultConsts.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize countLabel;

@synthesize tableListItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableListItems = [[NSMutableArray alloc] init];
    NSString *imgPath = @"world_red.png";
//    for (int i=0; i<33; i++) {
//        NSString *nameValue = [NSString stringWithFormat:@"号码：%d",i + 1];
//        NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:nameValue,@"name", imgPath,@"path", nil];
//        [tableListItems addObject:itemDic];
//    }
    
    for (NSString *resultStr in [ResultConsts sharedManager].resultArray) {
        NSString *nameValue = resultStr;
        NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:nameValue,@"name", imgPath,@"path", nil];
        [tableListItems addObject:itemDic];
    }
    
    countLabel.text = [NSString stringWithFormat:@"共%@注",[ResultConsts sharedManager].count] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableListItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.tableListItems objectAtIndex:row];
    cell.textLabel.text = [rowDict objectForKey:@"name"];
    cell.imageView.image = [UIImage imageNamed:[rowDict objectForKey:@"path"]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

@end
