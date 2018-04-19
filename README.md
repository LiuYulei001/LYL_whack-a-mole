# LYL_whack-a-mole
一款简单的打地鼠小游戏，涉及到音频、动画、计算、视图等各种配合！

1.视图布局

两层for循环布局九宫格，没个格子都是一个MouseItemView视图；

MouseItemView视图：

设置MouseItemViewDelegate：- (void)hitMouse:(MouseItemView *)mouseItem;//打中地鼠后回调

- (void)mouseOutHole;//地鼠出洞(动画)

- (void)mouseInHole;//地鼠回洞(动画)

2.音频工具GameSoundTool：用于背景音乐及打击音效

@property(nonatomic,assign,readonly)BOOL isPlaying;//是否正在播放

@property(nonatomic,assign)BOOL circulating;//是否需要循环播放


- (void)playSoundWithURL:(NSURL *)soundURL;//播放

- (void)stopSound;//停止

