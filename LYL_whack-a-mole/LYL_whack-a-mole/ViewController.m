//
//  ViewController.m
//  LYL_whack-a-mole
//
//  Created by Rainy on 2018/4/18.
//  Copyright © 2018年 WealthOnline_iOS_team. All rights reserved.
//

#define UserDefaults [NSUserDefaults standardUserDefaults]

#define kMaxSore_KEY @"maxSore"

#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height

#import "ViewController.h"
#import "MouseItemView.h"



@interface ViewController ()<MouseItemViewDelegate>
{
    NSInteger _tempMouseIndex;
}

@property(nonatomic,assign)NSInteger level;

@property(nonatomic,assign)NSInteger hitMouseCount;

@property(nonatomic,strong)NSMutableArray<MouseItemView *> *itemsArray;

@property(nonatomic,strong)NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UILabel *currentScore_lab;
@property (weak, nonatomic) IBOutlet UILabel *maxSore_lab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setMouseViewItems];
    [self setData];
}

#pragma mark - MouseItemViewDelegate
- (void)hitMouse:(MouseItemView *)mouseItem
{
    self.hitMouseCount += 1;
    
    self.currentScore_lab.text = [NSString stringWithFormat:@"%ld",self.hitMouseCount];
}

#pragma mark - methods action
- (void)saveValueForValue:(id)value key:(NSString *)key
{
    [UserDefaults setValue:value forKey:key];
    [UserDefaults synchronize];
}
- (id)getValueForKey:(NSString *)key
{
    return [UserDefaults objectForKey:key];
}
- (void)timerStart
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(timerActionForMouseOutHold:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
}
- (void)timerStop
{
    if (self.myTimer) {
        
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
    [self.itemsArray[_tempMouseIndex] mouseInHole];
}
- (void)timerActionForMouseOutHold:(NSTimer *)timer
{
    [self.itemsArray[_tempMouseIndex] mouseInHole];
    NSInteger index = arc4random_uniform(9);
    if (index == _tempMouseIndex) {
        
        if (index == 0) {
            
            index += 1;
            
        }else if (index == 8) {
            
            index -= 1;
            
        }else
        {
            index -= 1;
        }
    }
    _tempMouseIndex = index;
    [self.itemsArray[index] mouseOutHole];
}

- (IBAction)starGame:(UIButton *)sender {
    
    if (sender.isSelected) {
        
        [sender setSelected:NO];
        [self timerStop];
        
        
        NSString *maxSore = [self getValueForKey:kMaxSore_KEY];
        
        if ([self.currentScore_lab.text integerValue] > [maxSore integerValue]) {
            
            [self saveValueForValue:self.currentScore_lab.text key:kMaxSore_KEY];
            self.maxSore_lab.text = self.currentScore_lab.text;
        }
        
    }else
    {
        self.hitMouseCount = 0;
        [sender setSelected:YES];
        [self timerStart];
    }
    
}

#pragma mark - setter
- (void)setData
{
    NSString *maxSore = [self getValueForKey:kMaxSore_KEY];

    if (maxSore != nil) {
        
        self.maxSore_lab.text = maxSore;
    }
}
- (void)setMouseViewItems
{
    CGFloat w = (kScreenWidth - 40)/3;
    
    CGFloat y = (kScreenHeight - (kScreenWidth - 40))/2;
    
    for (int i = 0; i < 3; i++) {
        
        for (int j = 0; j < 3; j++) {
            
            MouseItemView *itemView = [[MouseItemView alloc]initWithFrame:CGRectMake(20 + w * i, y + w * j, w, w)];
            itemView.delegate = self;
            
            itemView.backgroundColor = [UIColor clearColor];
            
            [self.itemsArray addObject:itemView];
            
            [self.view addSubview:itemView];
        }
    }
}
- (void)setHitMouseCount:(NSInteger)hitMouseCount
{
    _hitMouseCount = hitMouseCount;
}
#pragma mark - getter
- (NSMutableArray *)itemsArray
{
    if (!_itemsArray) {
        
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

@end
