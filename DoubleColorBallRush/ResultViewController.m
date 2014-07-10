//
//  ResultViewController.m
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-23.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultConsts.h"
#import "MainViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize countLabel;

@synthesize resultTable;

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
    UIBarButtonItem *clearBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearAllResult)];
//    UIButton *cBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [cBtn setTitle:@"清空" forState:UIControlStateNormal];
//    [cBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [cBtn addTarget:self action:@selector(clearAllResult) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *clearBtnItem = [[UIBarButtonItem alloc] initWithCustomView:cBtn];
//    UIBarButtonItem *clearBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(clearAllResult)];
    self.navigationItem.rightBarButtonItem = clearBtnItem;
    
    tableListItems = [[NSMutableArray alloc] init];
    NSString *imgPath = @"unionlott.jpg";
//    for (int i=0; i<33; i++) {
//        NSString *nameValue = [NSString stringWithFormat:@"号码：%d",i + 1];
//        NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:nameValue,@"name", imgPath,@"path", nil];
//        [tableListItems addObject:itemDic];
//    }
    
    for (NSString *resultStr in [ResultConsts sharedInstance].resultArray) {
        NSString *nameValue = resultStr;
        NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:nameValue,@"name", imgPath,@"path", nil];
        [tableListItems addObject:itemDic];
    }
    
    countLabel.text = [NSString stringWithFormat:@"共%@注",[ResultConsts sharedInstance].count] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeAction:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableListItems removeObjectAtIndex:indexPath.row];
        [resultTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        countLabel.text = [NSString stringWithFormat:@"共%d注",tableListItems.count];
        [[ResultConsts sharedInstance].resultArray removeObjectAtIndex:indexPath.row];
        [[ResultConsts sharedInstance] countMinusOne];
    }
}

//清除按钮点击
- (void)clearAllResult
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清空" message:@"确定要清空列表吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

//确认清除处理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        MainViewController *mainVC = [[self.navigationController viewControllers] objectAtIndex:0];
        [mainVC clearAllResultAction];
        [tableListItems removeAllObjects];
        countLabel.text = @"共0注";
        [resultTable reloadData];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
