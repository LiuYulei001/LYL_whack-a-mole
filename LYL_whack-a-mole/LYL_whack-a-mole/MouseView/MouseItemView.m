//
//  MouseItemView.m
//  LYL_whack-a-mole
//
//  Created by Rainy on 2018/4/18.
//  Copyright © 2018年 WealthOnline_iOS_team. All rights reserved.
//

#define kHuaCong    [UIImage imageNamed:@"花丛"]
#define kDiShu      [UIImage imageNamed:@"地鼠"]
#define kAiDaDiShu  [UIImage imageNamed:@"挨打地鼠"]


#import "MouseItemView.h"
#import "UIView+Extension.h"
#import "GameSoundTool.h"

@interface MouseItemView ()

@property(nonatomic,strong)UIImageView *holeIMG;
@property(nonatomic,strong)UIImageView *mouseIMG;

@property(nonatomic,strong)GameSoundTool *hitSound;

@end

@implementation MouseItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        [self addSubview:self.mouseIMG];
        [self addSubview:self.holeIMG];
    }
    return self;
}

- (void)hitMouseOn
{
    [self hitMouseSound];
    self.mouseIMG.image = kAiDaDiShu;
    
    [self hitMouseInHole];
}
- (void)hitMouseSound
{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"打中" ofType:@"m4a"];
    NSURL *url = [NSURL fileURLWithPath:pathString];
    [self.hitSound playSoundWithURL:url];
}
- (void)hitMouseItem:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hitMouse:)] && self.mouseIMG.Y < (self.Sh - self.Sh/3)) {
        
        [self hitMouseOn];
        
        [self.delegate hitMouse:self];
    }
}

- (void)mouseOutHole
{
    [UIView animateWithDuration:0.1 animations:^{
        
        self.mouseIMG.Y = 20;
        
    }];
}
- (void)mouseInHole
{
    [UIView animateWithDuration:0.1 animations:^{
        
        self.mouseIMG.Y = self.Sh - self.Sh/3;
        
    }];
}
- (void)hitMouseInHole
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.mouseIMG.Y = self.Sh - self.Sh/3;
        
    } completion:^(BOOL finished) {
        
        self.mouseIMG.image = kDiShu;
    }];
}
#pragma mark - getter
- (UIImageView *)holeIMG
{
    if (!_holeIMG) {
        
        _holeIMG = [[UIImageView alloc]initWithFrame:CGRectMake(5, self.Sh - self.Sh/3, self.Sw - 10, self.Sh/3)];
        _holeIMG.image = kHuaCong;
        
    }
    return _holeIMG;
}
- (UIImageView *)mouseIMG
{
    if (!_mouseIMG) {
        
        _mouseIMG = [[UIImageView alloc]initWithFrame:CGRectMake(self.Sw/3, self.Sh - self.Sh/3, self.Sw/3, self.Sh - self.Sh/3 - 20)];
        _mouseIMG.image = kDiShu;
        _mouseIMG.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hitMouseItem:)];
        [_mouseIMG addGestureRecognizer:tap];
    }
    return _mouseIMG;
}
- (GameSoundTool *)hitSound
{
    if (!_hitSound) {
        
        _hitSound = [[GameSoundTool alloc]init];
    }
    return _hitSound;
}
@end
