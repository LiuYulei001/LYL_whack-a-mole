//
//  GameSoundTool.m
//  LYL_whack-a-mole
//
//  Created by Rainy on 2018/4/18.
//  Copyright © 2018年 WealthOnline_iOS_team. All rights reserved.
//

#import "GameSoundTool.h"

#import <AVFoundation/AVFoundation.h>

@interface GameSoundTool ()

@property(nonatomic,retain)AVAudioPlayer *player;

@end

@implementation GameSoundTool

- (void)playSoundWithURL:(NSURL *)soundURL
{
    NSError *error = nil;
    
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:&error];
    
    if (self.circulating) {
        _player.numberOfLoops = -1;
        _player.volume = 0.5;
    }else
    {
        _player.volume = 1.0;
    }
    
    
    [_player prepareToPlay];
    
    [_player playAtTime:0];
    _player.currentTime = 0;
    
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
}
- (void)stopSound
{
    [self.player stop];
}

- (BOOL)isPlaying
{
    return self.player.isPlaying;
}

- (void)setCirculating:(BOOL)circulating
{
    _circulating = circulating;
}

@end
