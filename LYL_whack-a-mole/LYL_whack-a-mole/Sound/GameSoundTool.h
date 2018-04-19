//
//  GameSoundTool.h
//  LYL_whack-a-mole
//
//  Created by Rainy on 2018/4/18.
//  Copyright © 2018年 WealthOnline_iOS_team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSoundTool : NSObject

@property(nonatomic,assign,readonly)BOOL isPlaying;

//播放
- (void)playSoundWithURL:(NSURL *)soundURL;
//停止
- (void)stopSound;
//循环
@property(nonatomic,assign)BOOL circulating;

@end
