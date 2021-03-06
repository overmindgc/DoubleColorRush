//
//  MainViewController.m
//  DoubleColorBallRush
//
//  Created by 辰 宫 on 14-5-21.
//  Copyright (c) 2014年 gc. All rights reserved.
//

#import "MainViewController.h"
#import "DoubleColorRunBL.h"
#import "ResultConsts.h"
#import "ResultViewController.h"
#import "CommonUtils.h"
#import "ASValueTrackingSlider.h"

@interface MainViewController ()

@property UILabel *titleLabel;

@property UILabel *resultLabel;

@property UILabel *countLabel;

@property ASValueTrackingSlider *speedSlider;

@property UIButton *runBtn;

@property UIButton *analyseBtn;

@property UIButton *clearBtn;

@end

@implementation MainViewController
{
    //标记是否运行中
    BOOL isRunning;
    
    int count;
}

@synthesize titleLabel;

@synthesize resultLabel;

@synthesize countLabel;

@synthesize speedSlider;

@synthesize runBtn;

@synthesize analyseBtn;

@synthesize clearBtn;

@synthesize runTimer;

@synthesize runBL;

- (id)init
{
    self = [super init];
    
    if (self) {
        isRunning = NO;
        count = 0;
        runBL = [[DoubleColorRunBL alloc] init];
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    //添加主视图
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view = view;
    
    //背景图
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height + 20)];
//    UIImage *img = [UIImage imageNamed:@"big_bg.jpeg"];
//    bgImgView.image = img;
//    bgImgView.alpha = 1;
//    bgImgView.userInteractionEnabled = YES;
//    [self.view addSubview:bgImgView];
    
    //创建子组件
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, view.frame.size.width, 30)];
    titleLabel.text = @"双色球摇奖机";
    titleLabel.font = [UIFont fontWithName:@"Menlo" size:30];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //球的背景图
    UIImageView *ballBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width/2 - 247/2 + 2, view.frame.size.height - 322, 244, 33)];
    UIImage *ballBgImg = [UIImage imageNamed:@"balls_bg.png"];
    ballBgImgView.image = ballBgImg;
    ballBgImgView.alpha = 1;
    ballBgImgView.userInteractionEnabled = YES;
    [self.view addSubview:ballBgImgView];
    
    
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 320, view.frame.size.width, 30)];
    resultLabel.text = @"00 00 00 00 00 00 00";
    resultLabel.font = [UIFont fontWithName:@"Arial" size:25];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:resultLabel];
    
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 270, view.frame.size.width, 30)];
    [self setCountLabelTextWith:[NSNumber numberWithInt:0]];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countLabel];
    
    UILabel *speedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 175, view.frame.size.width, 30)];
    speedLabel.font = [UIFont fontWithName:@"Arial" size:15];
    speedLabel.text = @"-      Speed     +";
    speedLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:speedLabel];
    
//    speedSlider = [[UISlider alloc] initWithFrame:CGRectMake((view.frame.size.width - 220) / 2, 300, 220, 25)];
//    [speedSlider addTarget:self action:@selector(speedChangeAction) forControlEvents:UIControlEventValueChanged];
//    speedSlider.maximumValue = speedMax;
//    speedSlider.minimumValue = speedMin;
//    speedSlider.value = 0.05;
//    speedSlider.minimumTrackTintColor = [UIColor redColor];
//    speedSlider.maximumTrackTintColor = [CommonUtils hexStringToColor:@"#009CFF"];
//    [self.view addSubview:speedSlider];
    
    speedSlider = [[ASValueTrackingSlider alloc] initWithFrame:CGRectMake((view.frame.size.width - 220) / 2, view.frame.size.height - 200, 220, 25)];
    [speedSlider addTarget:self action:@selector(speedChangeAction) forControlEvents:UIControlEventValueChanged];
    speedSlider.maximumValue = 1;
    speedSlider.minimumValue = 0.01;
    speedSlider.value = 0.5;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [speedSlider setNumberFormatter:formatter];
    speedSlider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:26];
    speedSlider.popUpViewAnimatedColors = @[[UIColor purpleColor], [UIColor redColor], [UIColor orangeColor]];
    [self.view addSubview:speedSlider];
    
    
    runBtn = [[UIButton alloc] initWithFrame:CGRectMake((view.frame.size.width - 80) / 2, view.frame.size.height - 120, 80, 40)];
    [runBtn setTitle:@"Start" forState:UIControlStateNormal];
    [runBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [runBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [runBtn addTarget:self action:@selector(startRunAction) forControlEvents:UIControlEventTouchDown];
    runBtn.titleLabel.font = [UIFont systemFontOfSize:35];
    [self.view addSubview:runBtn];
    
    analyseBtn = [[UIButton alloc] initWithFrame:CGRectMake((view.frame.size.width - 120) / 2, view.frame.size.height - 50, 120, 25)];
    [analyseBtn setTitle:@"查看摇奖记录" forState:UIControlStateNormal];
    [analyseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [analyseBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [analyseBtn addTarget:self action:@selector(analyseBtnAction) forControlEvents:UIControlEventTouchDown];
    analyseBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    analyseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:analyseBtn];
    
    clearBtn = [[UIButton alloc] initWithFrame:CGRectMake((view.frame.size.width - 120) / 2, view.frame.size.height - 15, 120, 25)];
    [clearBtn setTitle:@"重置" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [clearBtn addTarget:self action:@selector(clearAllResultAction) forControlEvents:UIControlEventTouchDown];
    clearBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18];
    clearBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:clearBtn];
    
}

#pragma mark -处理函数

- (void)startRunAction
{
    if (isRunning == NO) {
         //点击开始处理
        [self startTimerRunWith:[self getFinalSpeed]];
    } else {
        //点击停止处理
        [self stopTimerRun:YES];
    }
    
}

- (void)speedChangeAction
{
    if (isRunning == YES) {
        [self stopTimerRun:NO];
        [self startTimerRunWith:[self getFinalSpeed]];
    }
}

//计算最终所用的速度值
- (float)getFinalSpeed
{
    float speedPercent = speedSlider.value * 100;
    float newSpeed = 1 / speedPercent;
    return newSpeed;
}

- (void)analyseBtnAction
{
    //结果视图创建
    ResultViewController *resultVC = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
    resultVC.title = @"摇奖结果";
    [self.navigationController pushViewController:resultVC animated:YES];
//    [self presentViewController:resultVC animated:YES completion:nil];
}

- (void)clearAllResultAction
{
    count = 0;
    [ResultConsts sharedInstance].count = [NSNumber numberWithInt:0];
    [[ResultConsts sharedInstance].resultArray removeAllObjects];
    [self setCountLabelTextWith:[ResultConsts sharedInstance].count];
    resultLabel.text = @"00 00 00 00 00 00 00";
}


//开始运行timer
- (void)startTimerRunWith:(float)speed
{
    [runBtn setTitle:@"Stop" forState:UIControlStateNormal];
    isRunning = YES;
    
    runTimer = [NSTimer timerWithTimeInterval:speed target:self selector:@selector(doTimerRun:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:runTimer forMode:NSDefaultRunLoopMode];
    
    clearBtn.hidden = YES;
}

//timer执行方法
- (void)doTimerRun:(NSTimer *) theTimer
{
    resultLabel.text = [runBL generateAndGetResult];
    
    count++;
}

//timer停止运行，forSave：是否记录
- (void)stopTimerRun:(BOOL)forSave
{
    [runBtn setTitle:@"Start" forState:UIControlStateNormal];
    isRunning = NO;

    [runTimer invalidate];
    runTimer = nil;
    if (forSave == YES) {
        [[ResultConsts sharedInstance] countPlusOne];
        [[ResultConsts sharedInstance] addOneResultToArray:resultLabel.text];
        [self setCountLabelTextWith:[ResultConsts sharedInstance].count];
    }
    
    clearBtn.hidden = NO;
}

- (void)setCountLabelTextWith:(NSNumber *)num
{
    countLabel.text = [NSString stringWithFormat:@"选中: %@ 注",num];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    //结果里边删除的话，同步一下
    [self setCountLabelTextWith:[ResultConsts sharedInstance].count];
}

- (void)viewDidDisappear:(BOOL)animated
{
    //视图不显示的时候停止timer
    if ([runTimer isValid]) {
        [self stopTimerRun:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self stopTimerRun:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
